//
//  DateHelper.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import Foundation

enum DateHelper {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()

    static func format(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
