//
//  TasksPresenterTests.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

import XCTest
@testable import ToDoList

final class TasksPresenterTests: XCTestCase {
    
    // MARK: - Properties
    
    var presenter: TasksPresenter!
    var mockInteractor: MockTasksInteractor!
    var mockRouter: MockTasksRouter!
    var mockView: MockTasksView!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockInteractor = MockTasksInteractor()
        mockRouter = MockTasksRouter()
        mockView = MockTasksView()
        presenter = TasksPresenter(interactor: mockInteractor, router: mockRouter)
        presenter.view = mockView
    }
    
    override func tearDown() {
        presenter = nil
        mockInteractor = nil
        mockRouter = nil
        mockView = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_viewDidLoad_callsFetchTasks() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchTasksCalled)
    }
    
    func test_viewDidAppear_callsReloadTasks() {
        presenter.viewDidAppear()
        XCTAssertTrue(mockInteractor.reloadTasksCalled)
    }
    
    func test_didTapAdd_showCreateTaskPage() {
        presenter.didTapAdd()
        XCTAssertTrue(mockRouter.showTaskPageCalled)
        if case .create = mockRouter.taskPageMode {
            // ok
        } else {
            XCTFail("Ожидался режим create")
        }
    }
    
    func test_didTapTask_showEditTaskPage() {
        let todo = makeTodo()
        presenter.didTapTask(todo: todo)
        XCTAssertTrue(mockRouter.showTaskPageCalled)
        if case .edit(let editedToDo) = mockRouter.taskPageMode {
            XCTAssertEqual(editedToDo.id, todo.id)
        } else {
            XCTFail("Ожидался режим edit")
        }
    }
    
    func test_didTapDelete_callsDeleteTask() {
        let todo = makeTodo()
        presenter.didTapDelete(todo: todo)
        XCTAssertTrue(mockInteractor.deleteTasksCalled)
        XCTAssertEqual(mockInteractor.deletedId, todo.id)
    }
    
    func test_didTapComplete_updatesViewAndCallsToggle() {
        let todo = makeTodo(isCompleted: false)
        presenter.didTapComplete(todo: todo)
        XCTAssertTrue(mockView.updateTaskCalled)
        XCTAssertEqual(mockView.updatedTodo?.isCompleted, true)
        XCTAssertTrue(mockInteractor.toggleCompleteCalled)
        XCTAssertEqual(mockInteractor.toggledTodo?.isCompleted, true)
    }
    
    func test_didTapShare_showShareSheet() {
        let todo = makeTodo()
        presenter.didTapShare(todo: todo)
        XCTAssertTrue(mockRouter.showShareSheetCalled)
        XCTAssertEqual(mockRouter.sharedText, "\(todo.title)\n\(todo.taskDescription)")
    }
    
    func test_didSearchTasks_callSearch() {
        presenter.didSearchTasks(query: "тест")
        XCTAssertTrue(mockInteractor.searchTasksCalled)
        XCTAssertEqual(mockInteractor.searchQuery, "тест")
    }
    
    func test_didFetchTasks_showsTasksAndUpdatesCount() {
        let todos = [makeTodo(), makeTodo(id: 2)]
        presenter.didFetchTasks(todos)
        XCTAssertTrue(mockView.showTasksCalled)
        XCTAssertEqual(mockView.shownTodos.count, 2)
        XCTAssertTrue(mockView.updateTaskCountCalled)
        XCTAssertEqual(mockView.shownCount, 2)
    }
    
    func test_didFailWithError_showsError() {
        presenter.didFailWithError("Ошибка сети")
        XCTAssertTrue(mockView.showErrorCalled)
        XCTAssertEqual(mockView.shownError, "Ошибка сети")
    }
    
    
    // MARK: - Helpers
    
    private func makeTodo(id: Int = 1, isCompleted: Bool = false) -> ToDo {
        ToDo(
            id: id,
            title: "Тест",
            taskDescription: "Описание",
            isCompleted: isCompleted,
            createdAt: Date()
        )
    }
}
