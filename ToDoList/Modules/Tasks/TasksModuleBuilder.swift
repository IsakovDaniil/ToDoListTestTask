//
//  TasksModuleBulder.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import UIKit

final class TasksModuleBuilder {
    static func build() -> TasksViewController {
        let interactor = TasksInteractor()
        let router = TasksRouter()
        let presenter = TasksPresenter(interactor: interactor, router: router)
        let viewController = TasksViewController()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
        
    }
}
