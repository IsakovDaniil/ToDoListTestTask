//
//  TasksInteractor.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import Foundation

protocol TasksInteractorProtocol: AnyObject {
    
}

final class TasksInteractor {
    weak var presenter: TasksPresenterProtocol?
}

extension TasksInteractor: TasksInteractorProtocol {
    
}
