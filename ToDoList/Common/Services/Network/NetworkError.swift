//
//  NetworkError.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import Foundation
import RswiftResources

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case serverError(statusCode: Int)
    case decodingFailed(Error)
    case unknown(Error?)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            R.string.localizable.errorNetworkInvalidURL()
        case .noData:
            R.string.localizable.errorNetworkNoData()
        case .serverError(let code):
            String(format: R.string.localizable.errorNetworkServerError(code), code)
        case .decodingFailed(let error):
            "\(R.string.localizable.errorNetworkDecodingFailed()): \(error.localizedDescription)"
        case .unknown(let error):
            error?.localizedDescription ?? R.string.localizable.errorNetworkUnknown()
        }
    }
}
