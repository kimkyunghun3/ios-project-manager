//
//  DatabaseManager.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/19.
//

import Foundation

import RxSwift
import RxRelay

protocol DatabaseManagerProtocol {
    var todoListBehaviorRelay: BehaviorRelay<[Todo]> { get }
    var updateBehaviorRelay: BehaviorRelay<[History]> { get }
    
    func create(todoData: Todo)
    func read()
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
    func isConnected() -> Observable<Bool>
}

final class DatabaseManager: DatabaseManagerProtocol {
    let todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])
    let updateBehaviorRelay = BehaviorRelay<[History]>(value: [])

    private let realm = RealmDatabase()
    private let firebase = FirebaseDatabase()
    
    init() {
        self.read()
    }
    
    func isConnected() -> Observable<Bool> {
            return self.firebase.isConnected()
        }
    
    func create(todoData: Todo) {
        self.realm.create(todoData: todoData) { [weak self] todoData in
            self?.firebase.create(todoData: todoData)
        }
        
        self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + [todoData])
        self.updateBehaviorRelay.accept(self.updateBehaviorRelay.value + [todoData.convertHistory(action: .added, status: .from(currentStatus: .todo))])
    }

    func read() {
        self.realm.read { [weak self] todoData in
            self?.firebase.sync(todoData: todoData)
            self?.todoListBehaviorRelay.accept(todoData)
        }
    }

    func update(selectedTodo: Todo) {
        self.realm.update(selectedTodo: selectedTodo) { [weak self] selectedTodo in
            self?.firebase.update(selectedTodo: selectedTodo)
        }
        
        var todoList = self.todoListBehaviorRelay.value

        guard let todoItem = todoList.filter({ $0.identifier == selectedTodo.identifier }).first else {
            return
        }
        
        if selectedTodo.todoListItemStatus == todoItem.todoListItemStatus {
            self.edit(lastTodo: todoItem)
        } else {
            self.move(todoItem, to: selectedTodo.todoListItemStatus)
        }
        
        if let index = todoList.firstIndex(where: { $0.identifier == selectedTodo.identifier }) {
            todoList[index] = selectedTodo
        }
        self.todoListBehaviorRelay.accept(todoList)
    }
    
    private func edit(lastTodo: Todo) {
        let history = lastTodo.convertHistory(
            action: .edited,
            status: .from(currentStatus: lastTodo.todoListItemStatus)
        )
        self.updateBehaviorRelay.accept(self.updateBehaviorRelay.value + [history])
    }
    
    private func move(_ selectedTodo: Todo, to currentStatus: TodoListItemStatus) {
        let history = selectedTodo.convertHistory(
            action: .moved,
            status: .move(lastStatus: selectedTodo.todoListItemStatus, currentStatus: currentStatus)
        )
        self.updateBehaviorRelay.accept(self.updateBehaviorRelay.value + [history])
    }
    
    func delete(todoID: UUID) {
        self.realm.delete(todoID: todoID) { [weak self] uuid in
            self?.firebase.delete(todoID: uuid)
        }

        guard let todoItem = self.todoListBehaviorRelay.value.filter({ $0.identifier == todoID }).first else {
            return
        }
        
        let history = todoItem.convertHistory(action: .removed, status: .from(currentStatus: todoItem.todoListItemStatus))
        self.updateBehaviorRelay.accept(self.updateBehaviorRelay.value + [history])
        
        let todoItems = self.todoListBehaviorRelay.value.filter { $0.identifier != todoID }
        self.todoListBehaviorRelay.accept(todoItems)
    }
    
    func backup() {
        self.firebase.read { [weak self] todo in
            self?.realm.add(todoData: todo)
        }
    }
}
