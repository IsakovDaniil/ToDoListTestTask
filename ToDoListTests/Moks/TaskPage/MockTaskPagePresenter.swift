//
//  MockTaskPagePresenter.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

@testable import ToDoList

final class MockTaskPagePresenter: TaskPagePresenterProtocol {
    func viewDidLoad() {}
    func viewWillDisappear(title: String, description: String) {}
}
