//
//  ToDoEntity.swift
//  ToDoList
//
//  Created by Даниил on 10.03.2026.
//

import CoreData

@objc(ToDoEntity)
final class ToDoEntity: NSManagedObject {
    @NSManaged var id: Int64
    @NSManaged var title: String
    @NSManaged var taskDescription: String
    @NSManaged var isCompleted: Bool
    @NSManaged var createdAt: Date
}

// MARK: - Fetch Request
extension ToDoEntity {
    @nonobjc static func fetchRequest() -> NSFetchRequest<ToDoEntity> {
        NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
    }
}

// MARK: - Mapping → Domain
extension ToDoEntity {
    func toDomain() -> ToDo {
        ToDo(
            id: Int(id),
            title: title,
            taskDescription: taskDescription,
            isCompleted: isCompleted,
            createdAt: createdAt
        )
    }
}
