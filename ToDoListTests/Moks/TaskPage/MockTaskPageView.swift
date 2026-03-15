//
//  MockTaskPageView.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockTaskPageView: TaskPageViewProtocol {
    var configureCalled = false
    var configuredTodo: ToDo?
    
    func configure(with todo: ToDo) {
        configureCalled = true
        configuredTodo = todo
    }
}
