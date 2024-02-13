//
//  SecondTabView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct SecondTabView: View {
    @State private var showingSheet = false
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Present modal sheet") {
                showingSheet = true
            }
            Button("Log out") {
                isLoggedIn = false
            }
            .sheet(isPresented: $showingSheet) {
                ModalSheetView()
            }
        }
        .navigationTitle("Second stack")
    }
}

#Preview {
    SecondTabView(isLoggedIn: .constant(true))
}
