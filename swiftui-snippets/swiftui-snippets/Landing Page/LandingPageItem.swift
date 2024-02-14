//
//  LandingPageItem.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct LandingPageItem<PresentedView: View>: View {
    @State var showingModal = false
    var nonEssential = false
    var text: String
    var presentationView: PresentedView
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                showingModal = true
            }) {
                Text(text)
                    .foregroundStyle(.white)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .background(nonEssential ? Color.orange : Color.blue)
                    .cornerRadius(10)
            }
        }
        
        .fullScreenCover(isPresented: $showingModal, content: {
            VStack {
                presentationView
                DismissableView {
                    Text("\nTap to dismiss use case\n")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                }
            }
        })
    }
}

#Preview {
    LandingPageItem(text: "Test", presentationView: Text("Test"))
}
