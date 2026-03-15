//
//  MockTasksInteractor.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockTasksInteractor: TasksInteractorProtocol {
    var fetchTasksCalled = false
    var reloadTasksCalled = false
    var deleteTasksCalled = false
    var toggleCompleteCalled = false
    var searchTasksCalled = false
    
    var deletedId: Int?
    var toggledTodo: ToDo?
    var searchQuery: String?
    
    func fetchTasks() {
        fetchTasksCalled = true
    }
    
    func reloadTasks() {
        reloadTasksCalled = true
    }
    
    func deleteTasks(id: Int) {
        deleteTasksCalled = true
        deletedId = id
    }
    
    func toggleCompleted(todo: ToDo) {
        toggleCompleteCalled = true
        toggledTodo = todo
    }
    
    func searchTasks(query: String) {
        searchTasksCalled = true
        searchQuery = query
    }
}
