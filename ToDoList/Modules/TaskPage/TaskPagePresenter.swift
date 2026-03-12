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
    
    init(interactor: TaskPageInteractorProtocol, router: TaskPageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension TaskPagePresenter: TaskPagePresenterProtocol {
    
}
