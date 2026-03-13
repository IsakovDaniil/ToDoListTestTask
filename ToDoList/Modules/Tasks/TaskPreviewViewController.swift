//
//  TaskPreviewViewController.swift
//  ToDoList
//
//  Created by Даниил on 13.03.2026.
//

import UIKit

class TaskPreviewViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        
    }
    
    // MARK: - Properties
    
    private let todo: ToDo
    
    // MARK: - UIElements
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .appWhite
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appWhite
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appWhite.withAlphaComponent(0.5)
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    
    init(todo: ToDo) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        configure()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .appGray
        view.addSubview(textStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            textStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
        
        preferredContentSize = CGSize(
            width: UIScreen.main.bounds.width - 40,
            height: view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        )
    }
    
    // MARK: - Configure
    
    private func configure() {
        titleLabel.text = todo.title
        descriptionLabel.text = todo.taskDescription
        dateLabel.text = DateHelper.format(todo.createdAt)
    }
}
