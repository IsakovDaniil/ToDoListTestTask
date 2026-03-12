//
//  TaskPageViewController.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import UIKit

protocol TaskPageViewProtocol: AnyObject {
    
}

final class TaskPageViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let backButtonTitle = "Назад"
    }
    
    // MARK: - Properties
    
    var presenter: TaskPagePresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .appBlack
        
    }
    
    private func setupNavigationBar() {
        setupNavigationBarAppearance()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backButtonTitle = "Назад"
    }
    
}

extension TaskPageViewController: TaskPageViewProtocol {
    
}
