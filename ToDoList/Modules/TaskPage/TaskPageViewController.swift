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

    var presenter: TaskPagePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension TaskPageViewController: TaskPageViewProtocol {
    
}
