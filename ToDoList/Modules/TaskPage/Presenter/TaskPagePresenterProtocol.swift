//
//  TaskPagePresenterProtocol.swift
//  ToDoList
//
//  Created by Даниил on 14.03.2026.
//

protocol TaskPagePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillDisappear(title: String, description: String)
}
