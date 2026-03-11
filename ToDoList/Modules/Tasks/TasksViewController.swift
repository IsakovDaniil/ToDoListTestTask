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
        static let toolBarLabel = "Нет задач"
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
    
    private var toolBarLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет задач"
        label.textColor = .appWhite
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        button.tintColor = .appYellow
        return button
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
        setupToolBar()
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
    
    private func setupToolBar() {
        navigationController?.isToolbarHidden = false
        
        let appearance = UIToolbarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .appGray
        appearance.shadowColor = UIColor.white.withAlphaComponent(0.5)
        navigationController?.toolbar.standardAppearance = appearance
        navigationController?.toolbar.scrollEdgeAppearance = appearance
        
        let countItem = UIBarButtonItem(customView: toolBarLabel)
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbarItems = [flexibleSpace, countItem, flexibleSpace, addButton]
    }
    
    // MARK: - Actions
    
    @objc private func addButtonTapped() {
        print("tap")
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
