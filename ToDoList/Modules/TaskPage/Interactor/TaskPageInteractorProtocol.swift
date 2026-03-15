//
//  TaskPageInteractorProtocol.swift
//  ToDoList
//
//  Created by Даниил on 14.03.2026.
//

protocol TaskPageInteractorProtocol: AnyObject {
    func addTask(title: String, description: String)
    func updateTask(todo: ToDo, title: String, description: String)
}
