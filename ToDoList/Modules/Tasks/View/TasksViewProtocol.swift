//
//  TasksViewProtocol.swift
//  ToDoList
//
//  Created by Даниил on 14.03.2026.
//

protocol TasksViewProtocol: AnyObject {
    func showTasks(_ todos: [ToDo])
    func showError(_ message: String)
    func updateTaskCount(_ count: Int)
    func updateTask(_ todo: ToDo)
}
