//
//  StringHelper.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import Foundation

enum StringHelper {
    static func taskCountText(_ count: Int) -> String {
        String.localizedStringWithFormat(
            NSLocalizedString("tasks_count", comment: ""),
            count
        )
    }
}
