//
//  TasksInteractor.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import Foundation

final class TasksInteractor {
    
    // MARK: - Properties
    weak var presenter: TasksPresenterProtocol?
    
    private let storage: ToDoStorageProtocol
    private let network: NetworkClientProtocol
    
    // MARK: - Init
    
    init(storage: ToDoStorageProtocol = ToDoStorage(),
         network: NetworkClientProtocol = NetworkClient.shared) {
        self.storage = storage
        self.network = network
    }
}

extension TasksInteractor: TasksInteractorProtocol {
    
    // MARK: - Fetch
    
    func fetchTasks() {
        storage.isEmpty { [weak self] isEmpty in
            guard let self else { return }
            
            if isEmpty {
                self.loadFromNetwork()
            } else {
                self.loadFromStorage()
            }
        }
    }
    
    // MARK: - Search
    
    func searchTasks(query: String) {
        if query.isEmpty {
            loadFromStorage()
            return
        }
        
        storage.search(query: query) { [weak self] result in
            switch result {
            case .success(let todos):
                self?.presenter?.didFetchTasks(todos)
            case .failure(let error):
                self?.presenter?.didFailWithError(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Reload
    
    func reloadTasks() {
        loadFromStorage()
    }
    
    // MARK: - Delete
    
    func deleteTask(id: Int) {
        storage.delete(id: id) { [weak self] result in
            switch result {
            case .success:
                self?.loadFromStorage()
            case .failure(let error):
                self?.presenter?.didFailWithError(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Toggle Complete
    
    func toggleComplete(todo: ToDo) {
        storage.update(todo: todo) { _ in }
    }
    
    // MARK: - Private
    
    private func loadFromStorage() {
        storage.fetchAll { [weak self] result in
            switch result {
            case .success(let todos):
                self?.presenter?.didFetchTasks(todos)
            case .failure(let error):
                self?.presenter?.didFailWithError(error.localizedDescription)
            }
        }
    }
    
    private func loadFromNetwork() {
        network.fetchTodos { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                let todos = response.map { $0.toDomain() }
                self.storage.save(todos: todos) { [weak self] result in
                    switch result {
                    case .success:
                        self?.loadFromStorage()
                    case .failure(let error):
                        self?.presenter?.didFailWithError(error.localizedDescription)
                    }
                }
            case .failure(let error):
                self.presenter?.didFailWithError(error.localizedDescription)
            }
        }
    }
}
