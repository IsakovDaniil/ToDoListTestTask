//
//  ToDo.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import Foundation

struct ToDo {
    let id: Int
    var title: String
    var taskDescription: String
    var isCompleted: Bool
    var createdAt: Date
}

// MARK: - Mapping DTO → Domain

extension ToDoDTO {
    func toDomain() -> ToDo {
        ToDo(
            id: id,
            title: todo.components(separatedBy: " ").prefix(3).joined(separator: " "),
            taskDescription: todo,
            isCompleted: completed,
            createdAt: Date()
        )
    }
}
