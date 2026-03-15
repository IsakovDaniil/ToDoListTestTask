# <img src='https://github.com/IsakovDaniil/Isakov/blob/main/ToDoList/ToDoListIcon.png' alt='ToDoList' height='35'> ToDoList

Приложение для управления задачами, разработанное в рамках тестового задания.

## Скриншоты

![Скриншот ToDoListApp](https://github.com/IsakovDaniil/IsakovDaniil/blob/main/ToDoList/ToDoListAppCut.png?raw=true)

## Технологии

- **Язык:** Swift
- **UI:** UIKit
- **Архитектура:** VIPER
- **Хранение данных:** CoreData
- **Многопоточность:** GCD
- **Локализация:** R.swift
- **Тесты:** XCTest

## Функциональность

- Отображение списка задач
- Добавление, редактирование и удаление задач
- Поиск по задачам
- Отметка задачи как выполненной
- Загрузка задач из [dummyjson API](https://dummyjson.com/todos) при первом запуске
- Сохранение данных в CoreData
- Контекстное меню по долгому нажатию на задачу
- Поддержка русского и английского языков

## Архитектура

Проект построен на архитектуре **VIPER**:

- **View** — отображение данных, передача событий Presenter'у
- **Interactor** — бизнес логика, работа с сетью и CoreData
- **Presenter** — связующее звено между View и Interactor
- **Entity** — доменные модели (`ToDo`, `ToDoDTO`)
- **Router** — навигация между экранами

## Тесты

Покрыты юнит тестами:
- `TasksPresenterTests`
- `TasksInteractorTests`
- `TaskPagePresenterTests`
- `TaskPageInteractorTests`

## Автор

**[Daniil Isakov](https://github.com/IsakovDaniil)**
