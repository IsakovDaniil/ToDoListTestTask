//
//  NetworkClientProtocol.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

import Foundation

protocol NetworkClientProtocol {
    @discardableResult
    func fetchTodos(completion: @escaping (Result<[ToDoDTO], NetworkError>) -> Void) -> URLSessionDataTask?
}
