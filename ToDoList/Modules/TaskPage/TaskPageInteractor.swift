//
//  TaskPageInteractor.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import Foundation

protocol TaskPageInteractorProtocol: AnyObject {
    
}

final class TaskPageInteractor {
    weak var presenter: TaskPagePresenterProtocol?
}

extension TaskPageInteractor: TaskPageInteractorProtocol {
    
}
