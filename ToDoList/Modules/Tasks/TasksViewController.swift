//
//  TasksViewController.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import UIKit

protocol TasksViewProtocol: AnyObject {
    func showTasks(_ todos: [ToDo])
    func showError(_ message: String)
    func updateTaskCount(_ count: Int)
    func updateTask(_ todo: ToDo)
}

final class TasksViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = "Задачи"
        static let searchPlaceholder = "Search"
        static let toolBarLabel = "Нет задач"
        static let backButtonTitle = "Назад"
    }
    
    // MARK: - Properties
    
    var presenter: TasksPresenterProtocol?
    private var todos: [ToDo] = []
    
    // MARK: - UI Elements
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = Constants.searchPlaceholder
        return search
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .appBlack
        table.separatorColor = .appGray
        table.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        table.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        table.tableHeaderView = UIView()
        table.showsVerticalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var toolBarLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет задач"
        label.textColor = .appWhite
        label.font = AppFont.regular11
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
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
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .appBlack
        view.addSubview(tableView)
        setupNavigationBar()
        setupToolBar()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        setupNavigationBarAppearance()
        title = Constants.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.backButtonTitle = Constants.backButtonTitle
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
        presenter?.didTapAdd()
    }
}

// MARK: - UITableViewDataSource

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskCell.reuseIdentifier,
            for: indexPath
        ) as? TaskCell else {
            return UITableViewCell()
        }
        cell.configure(with: todos[indexPath.row])
        cell.onToggleComplete = { [weak self] in
            guard let self else { return }
            
            self.presenter?.didTapComplete(todo: self.todos[indexPath.row])
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapTask(todo: todos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        
        let todo = todos[indexPath.row]
        
        return UIContextMenuConfiguration(
            identifier: indexPath as NSIndexPath,
            previewProvider: {
                let preview = TaskPreviewViewController(todo: todo)
                return preview
            },
            actionProvider: { _ in
                let edit = UIAction(title: "Редактировать", image: UIImage(resource: .appEdit)) { [weak self] _ in
                    self?.presenter?.didTapTask(todo: todo)
                }
                let share = UIAction(title: "Поделиться", image: UIImage(resource: .appExport)) { [weak self] _ in
                    self?.presenter?.didTapShare(todo: todo)
                }
                let delete = UIAction(title: "Удалить", image: UIImage(resource: .appTrash), attributes: .destructive) { [weak self] _ in
                    self?.presenter?.didTapDelete(todo: todo)
                }
                return UIMenu(title: "", children: [edit, share, delete])
            }
        )
    }
}

// MARK: - UISearchResultsUpdating

extension TasksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        presenter?.didSearchTasks(query: query)
    }
}

// MARK: - TasksViewProtocol

extension TasksViewController: TasksViewProtocol {
    func showTasks(_ todos: [ToDo]) {
        self.todos = todos
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func updateTaskCount(_ count: Int) {
        toolBarLabel.text = StringHelper.taskCountText(count)
    }
    
    func updateTask(_ todo: ToDo) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos[index] = todo
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
}
