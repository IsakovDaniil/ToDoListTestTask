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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = false
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
