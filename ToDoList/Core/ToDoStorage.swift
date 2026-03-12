//
//  ToDoStorage.swift
//  ToDoList
//
//  Created by Даниил on 10.03.2026.
//

import CoreData

final class ToDoStorage: ToDoStorageProtocol {
    
    // MARK: - Init
    
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack = .shared) {
        self.stack = stack
    }
    
    // MARK: - Fetch All
    
    func fetchAll(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        let context = stack.newBackgroundContext()
        context.perform {
            do {
                let request = ToDoEntity.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
                let todos = try context.fetch(request).map { $0.toDomain() }
                DispatchQueue.main.async { completion(.success(todos)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
    // MARK: - Save
    
    func save(todos: [ToDo], completion: @escaping (Result<Void, any Error>) -> Void) {
        let context = stack.newBackgroundContext()
        context.perform {
            for todo in todos {
                let entity = ToDoEntity(context: context)
                entity.id = Int64(todo.id)
                entity.title = todo.title
                entity.taskDescription = todo.taskDescription
                entity.isCompleted = todo.isCompleted
                entity.createdAt = todo.createdAt
            }
            do {
                try context.save()
                DispatchQueue.main.async { completion(.success(())) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error))}
            }
        }
    }
    
    func add(todo: ToDo, completion: @escaping (Result<ToDo, any Error>) -> Void) {
        let context = stack.newBackgroundContext()
        context.perform {
            let entity = ToDoEntity(context: context)
            entity.id = Int64(todo.id)
            entity.title = todo.title
            entity.taskDescription = todo.taskDescription
            entity.isCompleted = todo.isCompleted
            entity.createdAt = todo.createdAt
            do {
                try context.save()
                DispatchQueue.main.async { completion(.success(todo)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error))}
            }
        }
    }
    
    func update(todo: ToDo, completion: @escaping (Result<Void, any Error>) -> Void) {
        let context = stack.newBackgroundContext()
        context.perform {
            let request = ToDoEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", todo.id)
            request.fetchLimit = 1
            do {
                guard let entity = try context.fetch(request).first else {
                    DispatchQueue.main.async { completion(.failure(StorageError.noFound)) }
                    return
                }
                entity.title = todo.title
                entity.taskDescription = todo.taskDescription
                entity.isCompleted = todo.isCompleted
                try context.save()
                DispatchQueue.main.async { completion(.success(())) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
    // MARK: - Delete
    
    func delete(id: Int, completion: @escaping (Result<Void, any Error>) -> Void) {
        let context = stack.newBackgroundContext()
        context.perform {
            let request = ToDoEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            request.fetchLimit = 1
            do {
                guard let entity = try context.fetch(request).first else {
                    DispatchQueue.main.async { completion(.failure(StorageError.noFound)) }
                    return
                }
                context.delete(entity)
                try context.save()
                DispatchQueue.main.async { completion(.success(())) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
    func search(query: String, completion: @escaping (Result<[ToDo], any Error>) -> Void) {
        let context = stack.newBackgroundContext()
        context.perform {
            let request = ToDoEntity.fetchRequest()
            request.predicate = NSPredicate(
                format: "title CONTAINS[cd] %@ OR taskDescription CONTAINS[cd] %@",
                query, query
            )
            request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            do {
                let todos = try context.fetch(request).map { $0.toDomain() }
                DispatchQueue.main.async { completion(.success(todos)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
    func isEmpty(completion: @escaping (Bool) -> Void) {
        let context = stack.newBackgroundContext()
        context.perform {
            let request = ToDoEntity.fetchRequest()
            request.fetchLimit = 1
            let count = (try? context.fetch(request).count) ?? .zero
            DispatchQueue.main.async { completion(count == .zero) }
        }
    }
}
