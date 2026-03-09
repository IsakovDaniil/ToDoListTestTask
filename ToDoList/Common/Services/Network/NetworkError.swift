//
//  NetworkError.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case serverError(statusCode: Int)
    case decodingFailed(Error)
    case unowned(Error?)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: "Неверный URL"
        case .noData: "Нет данных от сервера"
        case .serverError(let code): "Ошибка сервера: \(code)"
        case .decodingFailed(let error): "Ошибка декодирования: \(error.localizedDescription)"
        case .unowned(let error): error?.localizedDescription ?? "Неизвестная ошибка"
        }
    }
}
