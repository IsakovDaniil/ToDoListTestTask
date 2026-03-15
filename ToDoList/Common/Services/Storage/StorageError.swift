//
//  StorageError.swift
//  ToDoList
//
//  Created by Даниил on 10.03.2026.
//

import Foundation
import RswiftResources

enum StorageError: LocalizedError {
    case noFound
    
    var errorDescription: String? {
        R.string.localizable.errorStorageNotFound()
    }
}
