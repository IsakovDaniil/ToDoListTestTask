//
//  MockTasksPresenter.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockTasksPresenter: TasksPresenterProtocol {
    
    var didFetchTasksCalled = false
    var didFailWithErrorCalled = false
    var fetchedTodos: [ToDo]?
    var errorMessage: String?
    
    func viewDidLoad() {}
    func viewDidAppear() {}
    func didTapAdd() {}
    func didTapTask(todo: ToDo) {}
    func didTapDelete(todo: ToDo) {}
    func didTapComplete(todo: ToDo) {}
    func didTapShare(todo: ToDo) {}
    func didSearchTasks(query: String) {}
    
    func didFetchTasks(_ todos: [ToDo]) {
        didFetchTasksCalled = true
        fetchedTodos = todos
    }
    
    func didFailWithError(_ message: String) {
        didFailWithErrorCalled = true
        errorMessage = message
    }
}
