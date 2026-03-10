//
//  StorageError.swift
//  ToDoList
//
//  Created by Даниил on 10.03.2026.
//

import Foundation

enum StorageError: LocalizedError {
    case noFound
    
    var errorDescription: String? {
        "Задача не найдена"
    }
}
