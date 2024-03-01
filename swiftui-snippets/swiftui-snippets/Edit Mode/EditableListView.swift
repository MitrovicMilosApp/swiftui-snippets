//
//  EditableListView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct EditableListView: View {
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    @State var editMode: EditMode = .inactive
    //    IMPORTANT: the line below is a trap - it is not working properly if we use the edit mode value in more than one place
    //    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
                
                if $editMode.wrappedValue.isEditing {
                    Text("Editing Mode")
                } else {
                    Text("Normal Mode")
                }
            }
            
            .navigationTitle("Editable List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    EditableListView()
}
