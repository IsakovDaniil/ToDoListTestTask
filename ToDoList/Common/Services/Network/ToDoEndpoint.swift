//
//  Endpoint.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import Foundation

enum ToDoEndpoint {
    
    case fetchAll
    
    // MARK: - Private
    
    private var baseURL: String { API.baseURL }
    private var path: String { API.Todos.all }
    
    private var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "limit", value: "0")]
    }
    
    // MARK: - Public
    
    func makeRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        return request
    }
}
