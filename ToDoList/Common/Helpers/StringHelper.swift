//
//  StringHelper.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

enum StringHelper {
    static func taskCountText(_ count: Int) -> String {
        let remainder10 = count % 10
        let remainder100 = count % 100

        if remainder100 >= 11 && remainder100 <= 19 {
            return "\(count) Задач"
        }

        switch remainder10 {
        case 1: return "\(count) Задача"
        case 2, 3, 4: return "\(count) Задачи"
        default: return "\(count) Задач"
        }
    }
}
