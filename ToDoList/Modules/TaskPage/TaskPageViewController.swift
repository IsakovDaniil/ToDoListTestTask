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
        
    }
    
    // MARK: - Properties
    
    var presenter: TaskPagePresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .appBlack
        
    }
    
    private func setupNavigationBar() {
    }
    
}

extension TaskPageViewController: TaskPageViewProtocol {
    
}
