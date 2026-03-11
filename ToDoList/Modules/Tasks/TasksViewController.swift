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
        static let searchPlaceholder = "Search"
    }
    
    // MARK: - Properties
    
    var presenter: TasksPresenterProtocol!
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = Constants.searchPlaceholder
        return search
    }()
    
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
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UISearchResultsUpdating

extension TasksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        
        print(query)
    }
}

// MARK: - TasksViewProtocol

extension TasksViewController: TasksViewProtocol {
    
}
