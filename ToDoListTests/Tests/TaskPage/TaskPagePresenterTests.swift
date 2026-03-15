//
//  TaskPagePresenterTests.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

import XCTest
@testable import ToDoList

final class TaskPagePresenterTests: XCTestCase {
    
    var presenter: TaskPagePresenter!
    var mockInteractor: MockTaskPageInteractor!
    var mockRouter: MockTaskPageRouter!
    var mockView: MockTaskPageView!
    
    
    override func setUp() {
        super.setUp()
        mockInteractor = MockTaskPageInteractor()
        mockRouter = MockTaskPageRouter()
        mockView = MockTaskPageView()
    }
    
    override func tearDown() {
        presenter = nil
        mockInteractor = nil
        mockRouter = nil
        mockView = nil
        super.tearDown()
    }
    
    // MARK: - Helpers
    
    private func makePresenter(mode: TaskPageMode) -> TaskPagePresenter {
        let presenter = TaskPagePresenter(interactor: mockInteractor, router: mockRouter, mode: mode)
        presenter.view = mockView
        return presenter
    }
    
    private func makeTodo(id: Int = 1) -> ToDo {
        ToDo(id: id, title: "Тест", taskDescription: "Описание", isCompleted: false, createdAt: Date())
    }
    
    // MARK: - viewDidLoad
    
    func test_viewDidLoad_createMode_viewNotConfigured() {
        presenter = makePresenter(mode: .create)
        presenter.viewDidLoad()
        XCTAssertFalse(mockView.configureCalled)
    }
    
    func test_viewDidLoad_editMode_configuresView() {
        let todo = makeTodo()
        presenter = makePresenter(mode: .edit(todo))
        presenter.viewDidLoad()
        XCTAssertTrue(mockView.configureCalled)
        XCTAssertEqual(mockView.configuredTodo?.id, todo.id)
    }
    
    // MARK: - viewWillDisappear
    
    func test_viewWillDisappear_emptyTitle_doesNotSave() {
        presenter = makePresenter(mode: .create)
        presenter.viewWillDisappear(title: "", description: "Описание")
        XCTAssertFalse(mockInteractor.addTaskCalled)
    }
    
    func test_viewWillDisappear_createMode_addsTask() {
        presenter = makePresenter(mode: .create)
        presenter.viewWillDisappear(title: "Новая задача", description: "Описание")
        XCTAssertTrue(mockInteractor.addTaskCalled)
        XCTAssertEqual(mockInteractor.addedTitle, "Новая задача")
        XCTAssertEqual(mockInteractor.addedDescription, "Описание")
    }
    
    func test_viewWillDisappear_editMode_updatesTask() {
        let todo = makeTodo()
        presenter = makePresenter(mode: .edit(todo))
        presenter.viewWillDisappear(title: "Обновлённый заголовок", description: "Новое описание")
        XCTAssertTrue(mockInteractor.updateTaskCalled)
        XCTAssertEqual(mockInteractor.updatedTodo?.id, todo.id)
        XCTAssertEqual(mockInteractor.updatedTitle, "Обновлённый заголовок")
        XCTAssertEqual(mockInteractor.updatedDescription, "Новое описание")
    }
    
    func test_viewWillDisappear_editMode_doesNotAddTask() {
        let todo = makeTodo()
        presenter = makePresenter(mode: .edit(todo))
        presenter.viewWillDisappear(title: "Заголовок", description: "Описание")
        XCTAssertFalse(mockInteractor.addTaskCalled)
    }
    
    func test_viewWillDisappear_createMode_doesNotUpdateTask() {
        presenter = makePresenter(mode: .create)
        presenter.viewWillDisappear(title: "Заголовок", description: "Описание")
        XCTAssertFalse(mockInteractor.updateTaskCalled)
    }
}

