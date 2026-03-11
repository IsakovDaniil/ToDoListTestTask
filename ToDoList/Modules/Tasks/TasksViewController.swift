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
    
    var presenter: TasksPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}

extension TasksViewController: TasksViewProtocol {
    
}
