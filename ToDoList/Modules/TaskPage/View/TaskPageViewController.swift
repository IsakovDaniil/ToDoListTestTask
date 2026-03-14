//
//  TaskPageViewController.swift
//  ToDoList
//
//  Created by Даниил on 12.03.2026.
//

import UIKit



final class TaskPageViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let TextFieldPlaceholder = "Название"
        static let horizontalPadding: CGFloat = 20
        static let titleTopPadding: CGFloat = 8
        static let dateTopPadding: CGFloat = 8
        static let descriptionTopPadding: CGFloat = 16
    }
    
    // MARK: - Properties
    
    var presenter: TaskPagePresenterProtocol?
    
    // MARK: - UIElements
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFont.bold34
        textField.textColor = .appWhite
        
        textField.placeholder = Constants.TextFieldPlaceholder
        textField.borderStyle = .none
        textField.returnKeyType = .done
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular12
        label.textColor = .appWhiteOpacity
        label.text = DateHelper.format(Date())
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleTextField, dateLabel])
        stack.axis = .vertical
        stack.spacing = Constants.dateTopPadding
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = AppFont.regular16
        textView.textColor = .appWhite
        textView.tintColor = .appYellow
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = .zero
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = false
        presenter?.viewWillDisappear(
            title: titleTextField.text ?? "",
            description: descriptionTextView.text ?? ""
        )
    }
        
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .appBlack
        view.addSubview(headerStackView)
        view.addSubview(descriptionTextView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTopPadding),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            
            descriptionTextView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: Constants.descriptionTopPadding),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        navigationController?.isToolbarHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - UITextFieldDelegate

extension TaskPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        descriptionTextView.becomeFirstResponder()
        return true
    }
}

extension TaskPageViewController: TaskPageViewProtocol {
    func configure(with todo: ToDo) {
        titleTextField.text = todo.title
        descriptionTextView.text = todo.taskDescription
        dateLabel.text = DateHelper.format(todo.createdAt)
    }
}
