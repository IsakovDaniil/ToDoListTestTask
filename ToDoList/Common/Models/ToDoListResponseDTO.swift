//
//  ToDoListResponseDTO.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import Foundation

struct ToDoListResponseDTO: Decodable {
    let todos: [ToDoDTO]
}
