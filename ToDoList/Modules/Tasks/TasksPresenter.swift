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
    func didTapTask(todo: ToDo)
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
    
    // MARK: - View Events
    
    func viewDidLoad() {
        interactor.fetchTasks()
    }
    
    func didTapAdd() {
        router.showTaskPage(mode: .create)
    }
    
    func didTapTask(todo: ToDo) {
        router.showTaskPage(mode: .edit(todo))
    }
    
    func didTapDelete(todo: ToDo) {
        interactor.deleteTask(id: todo.id)
    }
    
    func didTapComplete(todo: ToDo) {
        interactor.toggleComplete(todo: todo)
    }
    
    func didTapShare(todo: ToDo) {
        let text = "\(todo.title)\n\(todo.taskDescription)"
        router.showShareSheet(text: text)
    }
    
    func didSearchTasks(query: String) {
        interactor.searchTasks(query: query)
    }
    
    // MARK: - Interactor Callbacks
    
    func didFetchTasks(_ todos: [ToDo]) {
        view?.showTasks(todos)
        view?.updateTaskCount(todos.count)
    }
    
    func didFailWithError(_ message: String) {
        view?.showError(message)
    }
}
