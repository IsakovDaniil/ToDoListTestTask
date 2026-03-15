//
//  TaskPageInteractorTests.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

import XCTest
@testable import ToDoList

final class TaskPageInteractorTests: XCTestCase {
    
    var interactor: TaskPageInteractor!
    var mockStorage: MockToDoStorage!
    var mockPresenter: MockTaskPagePresenter!
    
    override func setUp() {
        super.setUp()
        mockStorage = MockToDoStorage()
        mockPresenter = MockTaskPagePresenter()
        interactor = TaskPageInteractor(storage: mockStorage)
        interactor.presenter = mockPresenter
    }
    
    override func tearDown() {
        interactor = nil
        mockStorage = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    // MARK: - Add Task
    
    func test_addTask_callsStorageAdd() {
        interactor.addTask(title: "Тест", description: "Описание")
        XCTAssertTrue(mockStorage.addCalled)
    }
    
    func test_addTask_createsTaskWithCorrectTitle() {
        interactor.addTask(title: "Моя задача", description: "Описание")
        XCTAssertEqual(mockStorage.addedTodo?.title, "Моя задача")
    }
    
    func test_addTask_createsTaskWithCorrectDescription() {
        interactor.addTask(title: "Тест", description: "Моё описание")
        XCTAssertEqual(mockStorage.addedTodo?.taskDescription, "Моё описание")
    }
    
    func test_addTask_createsTaskNotCompleted() {
        interactor.addTask(title: "Тест", description: "Описание")
        XCTAssertEqual(mockStorage.addedTodo?.isCompleted, false)
    }
    
    // MARK: - Update Task
    
    func test_updateTask_callsStorageUpdate() {
        let todo = makeTodo()
        interactor.updateTask(todo: todo, title: "Новый", description: "Новое")
        XCTAssertTrue(mockStorage.updateCalled)
    }
    
    func test_updateTask_updatesTitle() {
        let todo = makeTodo()
        interactor.updateTask(todo: todo, title: "Обновлённый заголовок", description: "Описание")
        XCTAssertEqual(mockStorage.updatedTodo?.title, "Обновлённый заголовок")
    }
    
    func test_updateTask_updatesDescription() {
        let todo = makeTodo()
        interactor.updateTask(todo: todo, title: "Тест", description: "Обновлённое описание")
        XCTAssertEqual(mockStorage.updatedTodo?.taskDescription, "Обновлённое описание")
    }
    
    func test_updateTask_doesNotChangeIsCompleted() {
        let todo = makeTodo(isCompleted: true)
        interactor.updateTask(todo: todo, title: "Тест", description: "Описание")
        XCTAssertEqual(mockStorage.updatedTodo?.isCompleted, true)
    }
    
    func test_updateTask_keepsOriginalId() {
        let todo = makeTodo(id: 42)
        interactor.updateTask(todo: todo, title: "Тест", description: "Описание")
        XCTAssertEqual(mockStorage.updatedTodo?.id, 42)
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
