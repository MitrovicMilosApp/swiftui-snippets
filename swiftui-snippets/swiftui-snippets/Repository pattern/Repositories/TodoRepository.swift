//
//  TodoRepository.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 29.2.24..
//

import Combine
import Foundation

protocol TodoRepository {
    var name: String { get }
    func getAll() -> AnyPublisher<[Todo], Never>
    func add(_ todo: Todo) -> AnyPublisher<Void, Never>
    func setTodoTo(_ done: Bool, for id: UUID) -> AnyPublisher<Void, Never>
    func removeTodo(id: UUID) -> AnyPublisher<Void, Never>
}


