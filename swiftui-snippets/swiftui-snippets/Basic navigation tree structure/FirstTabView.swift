//
//  FirstTabView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct FirstTabView: View {
    @State private var showingModal = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Present full screen modal") {
                showingModal = true
            }
            .buttonStyle(.borderedProminent)
            NavigationLink(destination: DetailView()) {
                Text("Push to stack")
            }
            .fullScreenCover(isPresented: $showingModal) {
                FullScreenModalView()
            }
        }
        .navigationTitle("First stack")
    }
}

#Preview {
    FirstTabView()
}
