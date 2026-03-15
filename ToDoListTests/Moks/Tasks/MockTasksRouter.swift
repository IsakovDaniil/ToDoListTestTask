//
//  MockTasksRouter.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockTasksRouter: TasksRouterProtocol {
    var showTaskPageCalled = false
    var showShareSheetCalled = false
    var taskPageMode: TaskPageMode?
    var sharedText: String?
    
    func showTaskPage(mode: TaskPageMode) {
        showTaskPageCalled = true
        taskPageMode = mode
    }
    
    func showShareSheet(text: String) {
        showShareSheetCalled = true
        sharedText = text
    }
}
