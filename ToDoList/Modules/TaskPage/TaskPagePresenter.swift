//
//  TaskPagePresenter.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import Foundation

protocol TaskPagePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillDisappear(title: String, description: String)
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
    func viewDidLoad() {
        if case .edit(let todo) = mode {
            view?.configure(with: todo)
        }
    }
    
    func viewWillDisappear(title: String, description: String) {
        guard !title.isEmpty else { return }
        
        switch mode {
        case .create:
            interactor.addTask(title: title, description: description)
        case .edit(let todo):
            interactor.updateTask(todo: todo, title: title, description: description)
        }
    }
    
    
}
