//
//  TasksPresenterProtocol.swift
//  ToDoList
//
//  Created by Даниил on 14.03.2026.
//

protocol TasksPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func didTapAdd()
    func didTapTask(todo: ToDo)
    func didTapDelete(todo: ToDo)
    func didTapComplete(todo: ToDo)
    func didTapShare(todo: ToDo)
    func didSearchTasks(query: String)
    func didFetchTasks(_ todos: [ToDo])
    func didFailWithError(_ message: String)
}
