//
//  TodoView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 29.2.24..
//

import SwiftUI

struct TodoView: View {
    @ObservedObject var viewModel: TodoViewModel
    @State private var newTodoText: String = ""
    @State var selectedRepositoryType: Bool = false

    var body: some View {
        if selectedRepositoryType {
            NavigationView {
                List {
                    ForEach(viewModel.todos) { todo in
                        TodoRow(todo: todo, toggleDone: {
                            viewModel.toggleDone(for: todo)
                        })
                    }
                    .onDelete(perform: deleteTodo)
                    
                    HStack {
                        TextField("New Todo", text: $newTodoText)
                        Button(action: addTodo) {
                            Text("Add")
                        }
                    }
                }
                .navigationTitle("Todos from \(viewModel.repositoryName)")
            }
        } else {
            Spacer()
            VStack(spacing: 20) {
                Text("Please select repository type:")
                Button("In Memory") {
                    viewModel.switchRepositoryTo(.inMemory)
                    selectedRepositoryType = true
                }
                Button("Core Data") {
                    viewModel.switchRepositoryTo(.coreData)
                    selectedRepositoryType = true
                }
                Button("User Defaults") {
                    viewModel.switchRepositoryTo(.userDefaults)
                    selectedRepositoryType = true
                }
            }
            Spacer()
        }
    }
    
    private func addTodo() {
        let newTodo = Todo(id: UUID(), text: newTodoText, done: false)
        viewModel.add(todo: newTodo)
        newTodoText = ""
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        offsets.forEach { index in
            let todo = viewModel.todos[index]
            viewModel.remove(todo: todo)
        }
    }
}

#Preview {
    TodoView(viewModel: TodoViewModel(repository: InMemoryRepository()))
}
