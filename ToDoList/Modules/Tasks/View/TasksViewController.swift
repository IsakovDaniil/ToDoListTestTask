//
//  TasksViewController.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import UIKit
import RswiftResources

final class TasksViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = R.string.localizable.tasksTitle()
        static let searchPlaceholder = R.string.localizable.tasksSearchPlaceholder()
        static let backButtonTitle = R.string.localizable.tasksBack()
        
        static let toolBarNoTask = R.string.localizable.tasksToolbarNoTasks()
        
        static let editTitle = R.string.localizable.taskContextEdit()
        static let shareTitle = R.string.localizable.taskContextShare()
        static let deleteTitle = R.string.localizable.taskContextDelete()
        
        static let errorTitle = R.string.localizable.errorTitle()
        static let okButton = R.string.localizable.errorOk()
        
        static let horizontalPadding: CGFloat = 20
        static let toolMinimumScale: CGFloat = 0.5
        static let toolNumberOfLines = 1
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
        table.separatorInset = UIEdgeInsets(top: .zero, left: Constants.horizontalPadding, bottom: .zero, right: Constants.horizontalPadding)
        table.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        table.tableHeaderView = UIView()
        table.showsVerticalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let toolBarLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.toolBarNoTask
        label.textColor = .appWhite
        label.font = AppFont.regular11
        label.numberOfLines = Constants.toolNumberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = Constants.toolMinimumScale
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage.Icon.edit,
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
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
        appearance.shadowColor = .appWhiteOpacity
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
        presenter?.didTapComplete(todo: todos[indexPath.row])
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
                let edit = UIAction(title: Constants.editTitle, image: UIImage(resource: .appEdit)) { [weak self] _ in
                    self?.presenter?.didTapTask(todo: todo)
                }
                let share = UIAction(title: Constants.shareTitle, image: UIImage(resource: .appExport)) { [weak self] _ in
                    self?.presenter?.didTapShare(todo: todo)
                }
                let delete = UIAction(title: Constants.deleteTitle, image: UIImage(resource: .appTrash), attributes: .destructive) { [weak self] _ in
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
        let alert = UIAlertController(title: Constants.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okButton, style: .default))
        present(alert, animated: true)
    }
    
    func updateTaskCount(_ count: Int) {
        toolBarLabel.text = StringHelper.taskCountText(count)
    }
    
    func updateTask(_ todo: ToDo) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos[index] = todo
        tableView.reloadRows(at: [IndexPath(row: index, section: .zero)], with: .none)
    }
}
