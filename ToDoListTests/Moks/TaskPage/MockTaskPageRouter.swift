//
//  MockTaskPageRouter.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockTaskPageRouter: TaskPageRouterProtocol {
    var dismissCalled = false
    
    func dismiss() {
        dismissCalled = true
    }
}
