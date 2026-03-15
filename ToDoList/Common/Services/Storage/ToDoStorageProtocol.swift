//
//  ToDoStorageProtocol.swift
//  ToDoList
//
//  Created by Даниил on 10.03.2026.
//

protocol ToDoStorageProtocol {
    func fetchAll(completion: @escaping (Result<[ToDo], Error>) -> Void)
    func save(todos: [ToDo], completion: @escaping (Result<Void, Error>) -> Void)
    func add(todo: ToDo, completion: @escaping (Result<ToDo, Error>) -> Void)
    func update(todo: ToDo, completion: @escaping (Result<Void, Error>) -> Void)
    func delete(id: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func search(query: String, completion: @escaping (Result<[ToDo], Error>) -> Void)
    func isEmpty(completion: @escaping (Bool) -> Void)
}
