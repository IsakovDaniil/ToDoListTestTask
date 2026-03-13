//
//  TaskPageRouter.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import UIKit

protocol TaskPageRouterProtocol: AnyObject {
    func dismiss()
}

final class TaskPageRouter: TaskPageRouterProtocol {
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
