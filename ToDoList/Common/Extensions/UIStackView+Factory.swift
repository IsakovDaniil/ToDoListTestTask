//
//  UIStackView+Factory.swift
//  ToDoList
//
//  Created by Даниил on 13.03.2026.
//

import UIKit

extension UIStackView {
    static func taskTextStackView(with labels: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
