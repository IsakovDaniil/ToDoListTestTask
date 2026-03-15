//
//  TaskCell.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let checkboxSize: CGFloat = 24
        static let checkboxBorderWidth: CGFloat = 1
        static let verticalPadding: CGFloat = 12
        static let horizontalPadding: CGFloat = 20
        static let spacing: CGFloat = 8
        static let stackSpacing: CGFloat = 6
    }
    
    static let reuseIdentifier = String(describing: TaskCell.self)
    var onToggleComplete: (() -> Void)?
    
    // MARK: - UI Elements
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.checkboxSize / 2
        button.layer.borderWidth = Constants.checkboxBorderWidth
        button.layer.borderColor = UIColor.appStroke.cgColor
        button.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel = UILabel.taskTitleLabel()
    private let descriptionLabel = UILabel.taskDescriptionLabel()
    private let dateLabel = UILabel.taskDateLabel()
    private lazy var textStackView = UIStackView.taskTextStackView(with: [titleLabel, descriptionLabel, dateLabel])
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
        titleLabel.text = nil
        checkboxButton.layer.borderColor = UIColor.appStroke.cgColor
        checkboxButton.setImage(nil, for: .normal)
        descriptionLabel.textColor = .appWhite
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .appBlack
        selectionStyle = .none
        contentView.addSubview(checkboxButton)
        contentView.addSubview(textStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
            checkboxButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalPadding),
            checkboxButton.widthAnchor.constraint(equalToConstant: Constants.checkboxSize),
            checkboxButton.heightAnchor.constraint(equalToConstant: Constants.checkboxSize),
            
            textStackView.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: Constants.spacing),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalPadding),
            textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalPadding)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with todo: ToDo) {
        titleLabel.text = todo.title
        descriptionLabel.text = todo.taskDescription
        dateLabel.text = DateHelper.format(todo.createdAt)
        setCompleted(todo.isCompleted, title: todo.title)
    }
    
    // MARK: - Private Methods
    
    private func setCompleted(_ isCompleted: Bool, title: String) {
        checkboxButton.layer.borderColor = isCompleted ? UIColor.appYellow.cgColor : UIColor.appStroke.cgColor
        checkboxButton.setImage(isCompleted ? UIImage(resource: .appTick) : nil, for: .normal)
        checkboxButton.tintColor = .appYellow
        
        if isCompleted {
            let attributes: [NSAttributedString.Key: Any] = [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.appWhiteOpacity
            ]
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        } else {
            titleLabel.attributedText = nil
            titleLabel.text = title
        }
        
        descriptionLabel.textColor = isCompleted ? .appWhiteOpacity : .appWhite
    }
    
    // MARK: - Action
    
    @objc private func checkboxTapped() {
        onToggleComplete?()
    }
}
