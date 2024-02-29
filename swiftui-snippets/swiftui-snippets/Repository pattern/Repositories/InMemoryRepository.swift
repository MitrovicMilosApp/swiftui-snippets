//
//  InMemoryRepository.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 29.2.24..
//

import Foundation
import Combine

class InMemoryRepository: TodoRepository {
    var name: String = "In Memory Repository"
    private var todos: [UUID: Todo] = [:]

    func getAll() -> AnyPublisher<[Todo], Never> {
        Just(todos.values.sorted { $0.date < $1.date }).eraseToAnyPublisher()
    }

    func add(_ todo: Todo) -> AnyPublisher<Void, Never> {
        todos[todo.id] = todo
        return Just(()).eraseToAnyPublisher()
    }

    func setTodoTo(_ done: Bool, for id: UUID) -> AnyPublisher<Void, Never> {
        if var todo = todos[id] {
            todo.done = done
            todos[id] = todo
        }
        return Just(()).eraseToAnyPublisher()
    }

    func removeTodo(id: UUID) -> AnyPublisher<Void, Never> {
        todos.removeValue(forKey: id)
        return Just(()).eraseToAnyPublisher()
    }
}
