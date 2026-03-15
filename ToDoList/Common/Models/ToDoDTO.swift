//
//  ToDoDTO.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import Foundation

struct ToDoDTO: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
