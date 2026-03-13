//
//  TaskPageInteractor.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import Foundation

protocol TaskPageInteractorProtocol: AnyObject {
    func addTask(title: String, description: String)
    func updateTask(todo: ToDo, title: String, description: String)
}

final class TaskPageInteractor {
    weak var presenter: TaskPagePresenterProtocol?
}

extension TaskPageInteractor: TaskPageInteractorProtocol {
    
}
