//
//  TodoRow.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 29.2.24..
//

import SwiftUI

struct TodoRow: View {
    let todo: Todo
    let toggleDone: () -> Void
    
    var body: some View {
        HStack {
            Text(todo.text)
                .strikethrough(todo.done, color: .black)
            Spacer()
            if todo.done {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle()) 
        .onTapGesture {
            toggleDone()
        }
    }
}

#Preview {
    TodoRow(todo: Todo(id: UUID(), text: "Random text", done: false)) {
        
    }
}
