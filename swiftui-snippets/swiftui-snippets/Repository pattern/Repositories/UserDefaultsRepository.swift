//
//  UserDefaultsRepository.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 29.2.24..
//

import Foundation
import Combine

class UserDefaultsRepository: TodoRepository {
    var name: String = "User Defaults Repository"
    private let todosKey = "todos"
    private var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func getAll() -> AnyPublisher<[Todo], Never> {
        guard let data = userDefaults.data(forKey: todosKey) else {
            return Just([]).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        if let todos = try? decoder.decode([Todo].self, from: data) {
            return Just(todos).eraseToAnyPublisher()
        } else {
            return Just([]).eraseToAnyPublisher()
        }
    }
    
    func add(_ todo: Todo) -> AnyPublisher<Void, Never> {
        var currentTodos = loadTodos()
        currentTodos.append(todo)
        saveTodos(currentTodos)
        return Just(()).eraseToAnyPublisher()
    }
    
    func setTodoTo(_ done: Bool, for id: UUID) -> AnyPublisher<Void, Never> {
        var todos = loadTodos()
        if let index = todos.firstIndex(where: { $0.id == id }) {
            todos[index].done = done
            saveTodos(todos)
        }
        return Just(()).eraseToAnyPublisher()
    }
    
    func removeTodo(id: UUID) -> AnyPublisher<Void, Never> {
        var todos = loadTodos()
        todos.removeAll { $0.id == id }
        saveTodos(todos)
        return Just(()).eraseToAnyPublisher()
    }
    
    private func loadTodos() -> [Todo] {
        guard let data = userDefaults.data(forKey: todosKey) else {
            return []
        }
        let decoder = JSONDecoder()
        return (try? decoder.decode([Todo].self, from: data)) ?? []
    }
    
    private func saveTodos(_ todos: [Todo]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(todos) {
            userDefaults.set(encoded, forKey: todosKey)
        }
    }
}

