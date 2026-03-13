//
//  TasksRouter.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import UIKit

protocol TasksRouterProtocol: AnyObject {
    func showTaskPage(mode: TaskPageMode)
    func showShareSheet(text: String)
}

final class TasksRouter: TasksRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func showTaskPage(mode: TaskPageMode) {
        let taskPage = TaskPageModuleBuilder.build(mode: mode)
        viewController?.navigationController?.pushViewController(taskPage, animated: true)
    }
    
    func showShareSheet(text: String) {
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        viewController?.present(activityVC, animated: true)
    }
}
