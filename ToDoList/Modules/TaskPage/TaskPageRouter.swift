//
//  TaskPageRouter.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import Foundation

protocol TaskPageRouterProtocol: AnyObject {
    
}

final class TaskPageRouter: TaskPageRouterProtocol {
    weak var presenter: TaskPagePresenterProtocol?
}
