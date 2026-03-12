//
//  TasksInteractor.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func fetchTasks()
    func searchTasks(query: String)
    func deleteTask(id: Int)
    func toggleComplete(todo: ToDo)
}

final class TasksInteractor {
    weak var presenter: TasksPresenterProtocol?
}

extension TasksInteractor: TasksInteractorProtocol {
    
}
