//
//  TaskPagePresenter.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import Foundation

final class TaskPagePresenter {
    
    // MARK: - Properties
    weak var view: TaskPageViewProtocol?
    var router: TaskPageRouterProtocol
    var interactor: TaskPageInteractorProtocol
    let mode: TaskPageMode
    
    // MARK: - Init
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
        guard !title.isEmpty || !description.isEmpty else { return }
        
        let finalTitle = title.isEmpty
            ? description.components(separatedBy: " ").prefix(3).joined(separator: " ")
            : title

        switch mode {
        case .create:
            interactor.addTask(title: finalTitle, description: description)
        case .edit(let todo):
            interactor.updateTask(todo: todo, title: finalTitle, description: description)
        }
    }
    
}
