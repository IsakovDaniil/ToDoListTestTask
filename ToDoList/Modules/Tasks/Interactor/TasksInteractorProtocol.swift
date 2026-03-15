//
//  TasksInteractorProtocol.swift
//  ToDoList
//
//  Created by Даниил on 14.03.2026.
//

protocol TasksInteractorProtocol: AnyObject {
    func fetchTasks()
    func searchTasks(query: String)
    func deleteTask(id: Int)
    func reloadTasks()
    func toggleComplete(todo: ToDo)
}
