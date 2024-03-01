//
//  LandingPage.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        NavigationStack {
            List {
                LandingPageItem(text: "MVVM", presentationView: UserRegistrationView())
                LandingPageItem(text: "List & Detail", presentationView: MoviesListView())
                LandingPageItem(text: "Edit Mode", presentationView: EditableListView())
                LandingPageItem(text: "Gestures", presentationView: GesturesDemoView())
                LandingPageItem(text: "Navigation Structure", presentationView: ContentView())
                LandingPageItem(text: "Bar Graph", presentationView: BarGraphView())
                LandingPageItem(text: "Todo View", presentationView: TodoView(viewModel: TodoViewModel(repository: TodoRepositoryFactory.shared.getRepository(.inMemory))))
                LandingPageItem(text: "Rotating image", presentationView: RotatingImageView())
                LandingPageItem(text: "Scroll to open", presentationView: ScrollToOpen())
            }
            .navigationTitle("Use Cases")
        }
    }
}

#Preview {
    LandingPage()
}
