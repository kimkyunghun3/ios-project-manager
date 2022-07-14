//
//  ListView.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/06.
//

import UIKit

import RxCocoa
import RxSwift

final class ListView: UIView {
    private let todoListItemstatus: TodoListItemStatus
    private let tableView: UITableView
    private let listViewModel: TodoListViewModel
    private let disposeBag = DisposeBag()
    weak private var coordinator: AppCoordinator?
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = self.todoListItemstatus.value
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let listCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.backgroundColor = .label
        label.text = "5"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 18
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let todoListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init(todoListItemStatus: TodoListItemStatus, listViewModel: TodoListViewModel, coordinator: AppCoordinator) {
        self.todoListItemstatus = todoListItemStatus
        self.tableView = UITableView()
        self.listViewModel = listViewModel
        self.coordinator = coordinator
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setUpTableView()
        self.setUpListStackView()
        self.setUpHeaderView()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTableView() {
        self.tableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
    }
    
    private func setUpListStackView() {
        self.addSubview(self.todoListStackView)
        self.todoListStackView.addArrangedSubviews(with: [self.headerView, self.tableView])
        
        NSLayoutConstraint.activate([
            self.todoListStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.todoListStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.todoListStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.todoListStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpHeaderView() {
        self.headerView.addSubview(self.headerStackView)
        self.headerStackView.addArrangedSubviews(with: [self.headerTitleLabel, self.listCountLabel])
        
        NSLayoutConstraint.activate([
            self.headerStackView.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 10),
            self.headerStackView.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -10),
            self.headerStackView.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            self.listCountLabel.widthAnchor.constraint(equalTo: self.listCountLabel.heightAnchor)
        ])
    }
        
    private func bind() {
        Observable.of(
            (TodoListItemStatus.todo, self.listViewModel.todoViewData),
            (TodoListItemStatus.doing, self.listViewModel.doingViewData),
            (TodoListItemStatus.done, self.listViewModel.doneViewData)
        )
        .filter { $0.0 == self.todoListItemstatus }
        .flatMap{ $0.1 }
        .map { String($0.count) }
        .asDriver(onErrorJustReturn: "")
        .drive(self.listCountLabel.rx.text)
        .disposed(by: self.disposeBag)
        
        Observable.of(
            (TodoListItemStatus.todo, self.listViewModel.todoViewData),
            (TodoListItemStatus.doing, self.listViewModel.doingViewData),
            (TodoListItemStatus.done, self.listViewModel.doneViewData)
        )
        .filter { $0.0 == self.todoListItemstatus }
        .flatMap{ $0.1 }
        .asDriver(onErrorJustReturn: [])
        .drive(self.tableView.rx.items) { tabelView, row, element in
            guard let cell = tabelView.dequeueReusableCell(
                withIdentifier: TodoListCell.identifier,
                for: IndexPath(row: row, section: .zero)) as? TodoListCell
            else {
                return UITableViewCell()
            }
            cell.configure(element)
            
            return cell
        }
        .disposed(by: self.disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.listViewModel.cellSelectEvent(indexPathRow: indexPath.row, todoListItemStatus: self?.todoListItemstatus, completion: { [weak self] selectedTodo in
                    self?.coordinator?.showDetailView(todoListItemStatus: self?.todoListItemstatus, selectedTodo: selectedTodo)
                })
            })
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.modelDeleted(Todo.self)
            .subscribe(onNext: { [weak self] selectedTodo in
                self?.listViewModel.cellDeleteEvent(selectedTodo: selectedTodo)
            })
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.modelLongPressed(Todo.self)
            .subscribe(onNext: { [weak self] selectedCell, selectedData in
                guard let (firstStatus, secondStatus) = self?.listViewModel.distinguishMenuType(of: selectedData) else {
                    return
                }
                                
                self?.coordinator?.showPopOver(
                    sourceView: selectedCell,
                    firstTitle: "Move To \(firstStatus.value)",
                    secondTitle: "Move To \(secondStatus.value)",
                    firstAction: {
                        self?.listViewModel.moveDifferentSection(to: firstStatus, selectedCell: selectedData)
                    },
                    secondAction: {
                        self?.listViewModel.moveDifferentSection(to: secondStatus, selectedCell: selectedData)
                    })
            })
            .disposed(by: self.disposeBag)
    }
}
