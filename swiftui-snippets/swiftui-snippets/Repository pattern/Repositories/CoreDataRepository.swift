//
//  CoreDataRepository.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 29.2.24..
//

import Foundation
import Combine
import CoreData

class CoreDataRepository: TodoRepository {
    var name: String = "Core Data Repository"
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func getAll() -> AnyPublisher<[Todo], Never> {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            let todoEntities = try context.fetch(request)
            let todos = todoEntities.map { Todo(id: $0.id ?? UUID(), text: $0.text ?? "", done: $0.done, date: $0.date ?? Date()) }
            return Just(todos).eraseToAnyPublisher()
        } catch {
            return Just([]).eraseToAnyPublisher()
        }
    }

    func add(_ todo: Todo) -> AnyPublisher<Void, Never> {
        let entity = TodoEntity(context: context)
        entity.id = todo.id
        entity.text = todo.text
        entity.done = todo.done
        entity.date = todo.date
        saveContext()
        return Just(()).eraseToAnyPublisher()
    }

    func setTodoTo(_ done: Bool, for id: UUID) -> AnyPublisher<Void, Never> {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        if let todoEntity = try? context.fetch(request).first {
            todoEntity.done = done
            saveContext()
        }
        return Just(()).eraseToAnyPublisher()
    }

    func removeTodo(id: UUID) -> AnyPublisher<Void, Never> {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        if let todoEntity = try? context.fetch(request).first {
            context.delete(todoEntity)
            saveContext()
        }
        return Just(()).eraseToAnyPublisher()
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


