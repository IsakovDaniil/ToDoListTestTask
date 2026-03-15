//
//  MockNetworkClient.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList
import Foundation

final class MockNetworkClient: NetworkClientProtocol {
    
    var fetchTodosCalled = false
    var fetchTodosResult: Result<[ToDoDTO], NetworkError> = .success([])
    
    func fetchTodos(completion: @escaping (Result<[ToDoDTO], NetworkError>) -> Void) -> URLSessionDataTask? {
        fetchTodosCalled = true
        completion(fetchTodosResult)
        return nil
    }
}
