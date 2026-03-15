//
//  TasksInteractorTests.swift
//  ToDoList
//
//  Created by Даниил on 15.03.2026.
//

import XCTest
@testable import ToDoList

final class TasksInteractorTests: XCTestCase {
    
    // MARK: - Properties
    
    var interactor: TasksInteractor!
    var mockStorage: MockToDoStorage!
    var mockNetwork: MockNetworkClient!
    var mockPresenter: MockTasksPresenter!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockStorage = MockToDoStorage()
        mockNetwork = MockNetworkClient()
        mockPresenter = MockTasksPresenter()
        interactor = TasksInteractor(storage: mockStorage, network: mockNetwork)
        interactor.presenter = mockPresenter
    }
    
    override func tearDown() {
        interactor = nil
        mockStorage = nil
        mockNetwork = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    // MARK: - fetchTasks
    
    func test_fetchTasks_whenEmpty_loadFromNetwork() {
        mockStorage.isEmptyResult = true
        interactor.fetchTasks()
        XCTAssertTrue(mockNetwork.fetchTodosCalled)
    }
    
    func test_fetchTasks_whenNotEmpty_loadsFromStorage() {
        mockStorage.isEmptyResult = false
        interactor.fetchTasks()
        XCTAssertTrue(mockStorage.fetchAllCalled)
        XCTAssertFalse(mockNetwork.fetchTodosCalled)
    }
    
    func test_fetchTasks_fromStorage_presenterReceivesTodos() {
        let todos = [makeTodo(), makeTodo(id: 2)]
        mockStorage.isEmptyResult = false
        mockStorage.fetchAllResult = .success(todos)
        interactor.fetchTasks()
        XCTAssertTrue(mockPresenter.didFetchTasksCalled)
        XCTAssertEqual(mockPresenter.fetchedTodos?.count, 2)
        
    }
    
    func test_fetchTasks_fromNetwork_savesTodosToStorage() {
        let dtos = [makeDTO(), makeDTO(id: 2)]
        mockStorage.isEmptyResult = true
        mockNetwork.fetchTodosResult = .success(dtos)
        interactor.fetchTasks()
        XCTAssertTrue(mockStorage.saveCalled)
        XCTAssertEqual(mockStorage.savedTodos.count, 2)
    }
    
    func test_fetchTasks_storageError_presenterReceivesError() {
        mockStorage.isEmptyResult = false
        mockStorage.fetchAllResult = .failure(TestError.storageError)
        interactor.fetchTasks()
        XCTAssertTrue(mockPresenter.didFailWithErrorCalled)
        XCTAssertNotNil(mockPresenter.errorMessage)
    }
    
    func test_fetchTasks_networkError_presenterReceivesError() {
        mockStorage.isEmptyResult = true
        mockNetwork.fetchTodosResult = .failure(.noData)
        interactor.fetchTasks()
        XCTAssertTrue(mockPresenter.didFailWithErrorCalled)
    }
    
    // MARK: - searchTasks
    
    func test_searchTasks_emptyQuery_loadsFromStorage() {
        interactor.searchTasks(query: "")
        XCTAssertTrue(mockStorage.fetchAllCalled)
        XCTAssertFalse(mockStorage.searchCalled)
    }
    
    func test_searchTasks_withQuery_callsSearch() {
        interactor.searchTasks(query: "тест")
        XCTAssertTrue(mockStorage.searchCalled)
        XCTAssertEqual(mockStorage.searchQuery, "тест")
    }
    
    func test_searchTasks_presenterReceivesResults() {
        let todos = [makeTodo()]
        mockStorage.searchResult = .success(todos)
        interactor.searchTasks(query: "тест")
        XCTAssertTrue(mockPresenter.didFetchTasksCalled)
        XCTAssertEqual(mockPresenter.fetchedTodos?.count, 1)
    }
    
    // MARK: - deleteTask
    
    func test_deleteTask_success_reloadsTasks() {
        mockStorage.deleteResult = .success(())
        mockStorage.fetchAllResult = .success([])
        interactor.deleteTask(id: 1)
        XCTAssertTrue(mockStorage.deleteCalled)
        XCTAssertEqual(mockStorage.deletedId, 1)
        XCTAssertTrue(mockStorage.fetchAllCalled)
    }
    
    func test_deleteTask_failure_presenterReceivesError() {
        mockStorage.deleteResult = .failure(TestError.storageError)
        interactor.deleteTask(id: 1)
        XCTAssertTrue(mockPresenter.didFailWithErrorCalled)
    }
    
    // MARK: - toggleComplete
    
    func test_toggleComplete_callsStorageUpdate() {
        let todo = makeTodo()
        interactor.toggleComplete(todo: todo)
        XCTAssertTrue(mockStorage.updateCalled)
        XCTAssertEqual(mockStorage.updatedTodo?.id, todo.id)
    }
    
    // MARK: - reloadTasks
    
    func test_reloadTasks_loadsFromStorage() {
        interactor.reloadTasks()
        XCTAssertTrue(mockStorage.fetchAllCalled)
    }
    
    // MARK: - Helpers
    
    private func makeTodo(id: Int = 1) -> ToDo {
        ToDo(
            id: id,
            title: "Тест",
            taskDescription: "Описание",
            isCompleted: false,
            createdAt: Date()
        )
    }
    
    private func makeDTO(id: Int = 1) -> ToDoDTO {
        ToDoDTO(id: id, todo: "Тест задача", completed: false, userId: 1)
    }
}

// MARK: - TestError

enum TestError: Error {
    case storageError
}
