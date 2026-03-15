//
//  NetworkClient.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import Foundation

// MARK: - NetworkClient

final class NetworkClient: NetworkClientProtocol {
    
    // MARK: - Shared
    
    static let shared = NetworkClient()
    
    // MARK: - Private Properties
    
    private let session: URLSession
    private let decodeQueue = DispatchQueue(label: "NetworkClientDecodeQueue", qos: .userInitiated)
    
    // MARK: - Init
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Public Methods
    
    func fetchTodos(completion: @escaping (Result<[ToDoDTO], NetworkError>) -> Void) -> URLSessionDataTask? {
        let request: URLRequest
        do {
            request = try ToDoEndpoint.fetchAll.makeRequest()
        } catch {
            DispatchQueue.main.async { completion(.failure(.invalidURL)) }
            return nil
        }
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            
            if let error {
                DispatchQueue.main.async { completion(.failure(.unknown(error))) }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                DispatchQueue.main.async {
                    completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async { completion(.failure(.noData)) }
                return
            }
            
            self.decodeQueue.async {
                self.decode(data: data, completion: completion)
            }
        }
        
        task.resume()
        return task
    }
    
    // MARK: - Private Methods
    
    private func decode(data: Data, completion: @escaping (Result<[ToDoDTO], NetworkError>) -> Void) {
        do {
            let response = try JSONDecoder().decode(ToDoListResponseDTO.self, from: data)
            DispatchQueue.main.async { completion(.success(response.todos)) }
        } catch {
            DispatchQueue.main.async { completion(.failure(.decodingFailed(error))) }
        }
    }
}
