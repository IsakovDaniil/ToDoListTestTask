//
//  MockTaskPageInteractor.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockTaskPageInteractor: TaskPageInteractorProtocol {
    
    var addTaskCalled = false
    var updateTaskCalled = false
    
    var addedTitle: String?
    var addedDescription: String?
    var updatedTodo: ToDo?
    var updatedTitle: String?
    var updatedDescription: String?
    
    func addTask(title: String, description: String) {
        addTaskCalled = true
        addedTitle = title
        addedDescription = description
    }
    
    func updateTask(todo: ToDo, title: String, description: String) {
        updateTaskCalled = true
        updatedTodo = todo
        updatedTitle = title
        updatedDescription = description
    }
}
