//
//  MockTasksView.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockTasksView: TasksViewProtocol {
    
    var showTasksCalled = false
    var showErrorCalled = false
    var updateTaskCountCalled = false
    var updateTaskCalled = false
    
    var shownTodos: [ToDo] = []
    var shownError: String?
    var shownCount: Int?
    var updatedTodo: ToDo?
    
    func showTasks(_ todos: [ToDo]) {
        showTasksCalled = true
        shownTodos = todos
    }
    
    func showError(_ message: String) {
        showErrorCalled = true
        shownError = message
    }
    
    func updateTaskCount(_ count: Int) {
        updateTaskCountCalled = true
        shownCount = count
    }
    
    func updateTask(_ todo: ToDo) {
        updateTaskCalled = true
        updatedTodo = todo
    }
}
