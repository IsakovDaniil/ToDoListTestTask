//
//  TasksPresenter.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import Foundation

protocol TasksPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAdd()
    func didTapDelete(todo: ToDo)
    func didTapComplete(todo: ToDo)
    func didTapShare(todo: ToDo)
    func didSearchTasks(query: String)
    func didFetchTasks(_ todos: [ToDo])
    func didFailWithError(_ message: String)
}

final class TasksPresenter {
    weak var view: TasksViewProtocol?
    var router: TasksRouterProtocol
    var interactor: TasksInteractorProtocol
    
    init(interactor: TasksInteractorProtocol, router: TasksRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension TasksPresenter: TasksPresenterProtocol {
    func viewDidLoad() {
        
    }
}
