//
//  TaskPageInteractor.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import Foundation

final class TaskPageInteractor {
    weak var presenter: TaskPagePresenterProtocol?
    private let storage: ToDoStorageProtocol
    
    init(storage: ToDoStorageProtocol = ToDoStorage()) {
        self.storage = storage
    }
}

extension TaskPageInteractor: TaskPageInteractorProtocol {
    
    func addTask(title: String, description: String) {
        let todo = ToDo(
            id: abs(UUID().hashValue),
            title: title,
            taskDescription: description,
            isCompleted: false,
            createdAt: Date()
        )
        storage.add(todo: todo) { _ in }
    }
    
    func updateTask(todo: ToDo, title: String, description: String) {
        var updated = todo
        updated.title = title
        updated.taskDescription = description
        storage.update(todo: updated) { _ in }
    }
    
}
