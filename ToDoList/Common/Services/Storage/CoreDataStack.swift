//
//  CoreDataStack.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import CoreData

final class CoreDataStack {
    
    // MARK: - Singleton
    
    static let shared = CoreDataStack()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { _, error in
            if let error {
                assertionFailure("CoreData не загрузился: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // MARK: - Contexts
    
    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
}
