//
//  TaskPageModuleBuilder.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import UIKit

final class TaskPageModuleBuilder {
    static func build(mode: TaskPageMode) -> TaskPageViewController {
        let interactor = TaskPageInteractor()
        let router = TaskPageRouter()
        let presenter = TaskPagePresenter(interactor: interactor, router: router, mode: mode)
        let viewController = TaskPageViewController()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
        
    }
}
