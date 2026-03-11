//
//  MockData.swift
//  ToDoList
//
//  Created by Даниил on 11.03.2026.
//

import Foundation

enum MockData {
    static let todos: [ToDo] = [
        ToDo(
            id: 1,
            title: "Почитать книгу",
            taskDescription: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в хо...",
            isCompleted: true,
            createdAt: Date()
        ),
        ToDo(
            id: 2,
            title: "Уборка в квартире",
            taskDescription: "Провести генеральную уборку в квартире",
            isCompleted: false,
            createdAt: Date()
        ),
        ToDo(
            id: 3,
            title: "Заняться спортом",
            taskDescription: "Сходить в спортзал или сделать тренировку дома. Не забыть про разминку и растяжку!",
            isCompleted: false,
            createdAt: Date()
        ),
        ToDo(
            id: 4,
            title: "Работа над проектом",
            taskDescription: "Выделить время для работы над проектом на работе. Сфокусироваться на выполнении важного",
            isCompleted: true,
            createdAt: Date()
        ),
        ToDo(
            id: 5,
            title: "Вечерний отдых",
            taskDescription: "Найти время для расслабления перед сном: посмотреть фильм или послушать музыку",
            isCompleted: false,
            createdAt: Date()
        ),
        ToDo(
            id: 6,
            title: "Зарядка утром",
            taskDescription: "Сделать утреннюю зарядку для бодрости на весь день",
            isCompleted: false,
            createdAt: Date()
        ),
        ToDo(
            id: 7,
            title: "Позвонить маме",
            taskDescription: "Не забыть позвонить маме и узнать как дела",
            isCompleted: false,
            createdAt: Date()
        )
    ]
}
