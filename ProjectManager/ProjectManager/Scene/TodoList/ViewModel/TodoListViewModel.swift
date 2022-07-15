//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import UIKit

import RxCocoa
import RxRelay
import RxSwift

final class TodoListViewModel {
    let todoViewData: Driver<[Todo]>
    let doingViewData: Driver<[Todo]>
    let doneViewData: Driver<[Todo]>
    
    private var dataBase: DataBase
    
    init(dataBase: DataBase) {
        self.dataBase = dataBase
        
        self.todoViewData = dataBase.data
            .map { $0.filter { $0.todoListItemStatus == .todo } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
        
        self.doingViewData = dataBase.data
            .map { $0.filter { $0.todoListItemStatus == .doing } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
        
        self.doneViewData = dataBase.data
            .map { $0.filter { $0.todoListItemStatus == .done } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func cellSelectEvent(indexPathRow: Int, todoListItemStatus: TodoListItemStatus?, completion: @escaping (Todo) -> Void ) {
        guard let todoListItemStatus = todoListItemStatus else {
            return
        }
        
        switch todoListItemStatus {
        case .todo:
            self.todoViewData.drive(onNext: {
                completion($0[indexPathRow])
            })
            .dispose()
        case .doing:
            self.doingViewData.drive(onNext: {
                completion($0[indexPathRow])
            })
            .dispose()
        case .done:
            self.doneViewData.drive(onNext: {
                completion($0[indexPathRow])
            })
            .dispose()
        }
    }
    
    func cellDeleteEvent(selectedData: Todo) {
        self.dataBase.delete(identifier: selectedData.identifier)
    }
    
    func distinguishMenuType(of todo: Todo) -> (TodoListItemStatus, TodoListItemStatus) {
        switch todo.todoListItemStatus {
        case .todo: return (.doing, .done)
        case .doing: return (.todo, .done)
        case .done: return (.todo, .doing)
        }
    }
    
    func moveDifferentSection(to: TodoListItemStatus, selectedCell: Todo) {
        var selectedTodo = selectedCell
        
        guard let newStatus = TodoListItemStatus(rawValue: to.rawValue) else {
            return
        }
        
        selectedTodo.todoListItemStatus = newStatus
        self.dataBase.update(todo: selectedTodo)
    }
    
    func changeDateColor(cell: TodoListCell, todoData: Todo) {
        if todoData.date > Formatter.date.fetchCurrentDate() && todoData.todoListItemStatus != .done {
            cell.changeDateLabelColor(to: .red)
        } else {
            cell.changeDateLabelColor(to: .black)
        }
    }
}
