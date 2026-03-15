//
//  MockToDoStorage.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockToDoStorage: ToDoStorageProtocol {
    
    var fetchAllCalled = false
    var saveCalled = false
    var addCalled = false
    var updateCalled = false
    var deleteCalled = false
    var searchCalled = false
    var isEmptyCalled = false
    
    var deletedId: Int?
    var savedTodos: [ToDo] = []
    var updatedTodo: ToDo?
    var addedTodo: ToDo?
    var searchQuery: String?
    
    var fetchAllResult: Result<[ToDo], Error> = .success([])
    var saveResult: Result<Void, Error> = .success(())
    var addResult: Result<ToDo, Error>?
    var updateResult: Result<Void, Error> = .success(())
    var deleteResult: Result<Void, Error> = .success(())
    var searchResult: Result<[ToDo], Error> = .success([])
    var isEmptyResult = true
    
    func fetchAll(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        fetchAllCalled = true
        completion(fetchAllResult)
    }
    
    func save(todos: [ToDo], completion: @escaping (Result<Void, Error>) -> Void) {
        saveCalled = true
        savedTodos = todos
        completion(saveResult)
    }
    
    func add(todo: ToDo, completion: @escaping (Result<ToDo, Error>) -> Void) {
        addCalled = true
        addedTodo = todo
        completion(addResult ?? .success(todo))
    }
    
    func update(todo: ToDo, completion: @escaping (Result<Void, Error>) -> Void) {
        updateCalled = true
        updatedTodo = todo
        completion(updateResult)
    }
    
    func delete(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        deleteCalled = true
        deletedId = id
        completion(deleteResult)
    }
    
    func search(query: String, completion: @escaping (Result<[ToDo], Error>) -> Void) {
        searchCalled = true
        searchQuery = query
        completion(searchResult)
    }
    
    func isEmpty(completion: @escaping (Bool) -> Void) {
        isEmptyCalled = true
        completion(isEmptyResult)
    }
}
