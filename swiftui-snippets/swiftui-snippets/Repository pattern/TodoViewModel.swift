//
//  TodoViewModel.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 29.2.24..
//

import Foundation
import Combine

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var repositoryName: String
    private var cancellables = Set<AnyCancellable>()
    private let repository: TodoRepository
    
    init(repository: TodoRepository) {
        self.repository = repository
        self.repositoryName = repository.name
        bindTodos()
    }
    
    func bindTodos() {
        repository.getAll()
            .map({ $0.sorted(by: { $0.date < $1.date })})
            .assign(to: &$todos)
    }
    
    func add(todo: Todo) {
        repository.add(todo)
            .sink(receiveValue: { [weak self] _ in
                self?.bindTodos()
            })
            .store(in: &cancellables)
    }
    
    func toggleDone(for todo: Todo) {
        repository.setTodoTo(!todo.done, for: todo.id)
            .sink(receiveValue: { [weak self] _ in
                self?.bindTodos()
            })
            .store(in: &cancellables)
    }
    
    func remove(todo: Todo) {
        repository.removeTodo(id: todo.id)
            .sink(receiveValue: { [weak self] _ in
                self?.bindTodos()
            })
            .store(in: &cancellables)
    }
}

