//
//  TasksRouter.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import Foundation

protocol TasksRouterProtocol: AnyObject {
    func showTaskPage(mode: TaskPageMode)
    func showShareSheet(text: String)
}

final class TasksRouter: TasksRouterProtocol {
    weak var presenter: TasksPresenterProtocol?
}
