//
//  TasksRouterProtocol.swift
//  ToDoList
//
//  Created by Даниил on 14.03.2026.
//

protocol TasksRouterProtocol: AnyObject {
    func showTaskPage(mode: TaskPageMode)
    func showShareSheet(text: String)
}
