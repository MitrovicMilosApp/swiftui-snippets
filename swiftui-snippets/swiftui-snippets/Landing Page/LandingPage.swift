//
//  LandingPage.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        GeometryReader { geometry in
            
            ScrollView {
                let columns = [
                    GridItem(.flexible(), alignment: .center),
                    GridItem(.flexible(), alignment: .trailing)
                ]
                LazyVGrid(columns: columns, spacing: geometry.size.width * 0.45) {
                    
                    LandingPageItem(text: "MVVM", presentationView: UserRegistrationView())
                    LandingPageItem(text: "List &\nDetail", presentationView: MoviesListView())
                    LandingPageItem(text: "Edit Mode", presentationView: EditableListView())
                    LandingPageItem(text: "Gestures", presentationView: GesturesDemoView())
                    LandingPageItem(text: "Navigation\nStructure", presentationView: ContentView())
                    LandingPageItem(text: "Bar Graph", presentationView: BarGraphView())
                    LandingPageItem(text: "Todo View", presentationView: TodoView(viewModel: TodoViewModel(repository: InMemoryRepository())))
                    LandingPageItem(nonEssential: true, text: "Rotating image", presentationView: RotatingImageView())
                    LandingPageItem(nonEssential: true, text: "Scroll to open", presentationView: ScrollToOpen())
                }
                .padding()
            }
        }
    }
}

#Preview {
    LandingPage()
}
