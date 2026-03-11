//
//  TasksPresenter.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import Foundation

protocol TasksPresenterProtocol: AnyObject {
    
}

final class TasksPresenter {
    weak var view: TasksViewProtocol?
    var router: TasksRouterProtocol
    var interactor: TasksInteractorProtocol
    
    init(interactor: TasksInteractorProtocol, router: TasksRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension TasksPresenter: TasksPresenterProtocol {
    
}
