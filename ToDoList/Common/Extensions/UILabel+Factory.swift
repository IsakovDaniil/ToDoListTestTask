//
//  UILabel+Factory.swift
//  ToDoList
//
//  Created by Даниил on 13.03.2026.
//

import UIKit

extension UILabel {
    static func taskTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = AppFont.medium16
        label.textColor = .appWhite
        label.numberOfLines = 1
        return label
    }

    static func taskDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = AppFont.regular12
        label.textColor = .appWhite
        label.numberOfLines = 2
        return label
    }

    static func taskDateLabel() -> UILabel {
        let label = UILabel()
        label.font = AppFont.regular12
        label.textColor = .appWhite.withAlphaComponent(0.5)
        return label
    }
}
