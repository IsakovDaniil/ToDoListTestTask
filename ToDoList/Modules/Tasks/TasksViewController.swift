//
//  TasksViewController.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import UIKit

protocol TasksViewProtocol: AnyObject {
    
}

final class TasksViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = "Задачи"
    }
    
    // MARK: - Properties
    
    var presenter: TasksPresenterProtocol!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .appBlack
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = Constants.title
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

}

extension TasksViewController: TasksViewProtocol {
    
}
