//
//  MainTabView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct MainTabView: View {
    @Binding var isLoggedIn: Bool
    var body: some View {
        TabView {
            NavigationStack {
                FirstTabView()
            }
            .tabItem {
                Label("First", systemImage: "1.circle")
            }
            NavigationStack {
                SecondTabView(isLoggedIn: $isLoggedIn)
            }
            .tabItem {
                Label("Second", systemImage: "2.circle")
            }
        }
    }
}

#Preview {
    MainTabView(isLoggedIn: .constant(true))
}
