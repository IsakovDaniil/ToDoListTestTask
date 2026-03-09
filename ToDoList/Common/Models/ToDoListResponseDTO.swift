//
//  ToDoListRespnseDTO.swift
//  ToDoList
//
//  Created by Даниил on 09.03.2026.
//

import Foundation

struct ToDoListRespnoseDTO: Decodable {
    let todos: [ToDoDTO]
}
