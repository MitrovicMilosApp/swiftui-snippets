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

enum TodoRepositoryType {
    case inMemory
    case coreData
    case userDefaults
}

class TodoRepositoryFactory {
    private let inMemoryRepository = InMemoryRepository()
    private let coreDataRepository = CoreDataRepository()
    private let userDefaultsRepository = UserDefaultsRepository()
    
    static let shared = TodoRepositoryFactory()
    
    private init() {}
    
    func getRepository(_ type: TodoRepositoryType) -> TodoRepository {
        return switch type {
        case .inMemory:
            inMemoryRepository
        case .coreData:
            coreDataRepository
        case .userDefaults:
            userDefaultsRepository
        }
    }
}
