//
//  TaskPagePresenter.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import Foundation

protocol TaskPagePresenterProtocol: AnyObject {
    
}

final class TaskPagePresenter {
    weak var view: TaskPageViewProtocol?
    var router: TaskPageRouterProtocol
    var interactor: TaskPageInteractorProtocol
    let mode: TaskPageMode
    
    init(interactor: TaskPageInteractorProtocol, router: TaskPageRouterProtocol, mode: TaskPageMode) {
        self.interactor = interactor
        self.router = router
        self.mode = mode
    }
    
}

extension TaskPagePresenter: TaskPagePresenterProtocol {
    
}
