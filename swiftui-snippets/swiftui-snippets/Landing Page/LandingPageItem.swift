//
//  LandingPageItem.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct LandingPageItem<PresentedView: View>: View {
    @State var showingModal = false
    var text: String
    var presentationView: PresentedView
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                showingModal = true
            }) {
                Spacer(minLength: 5)
                Text(text)
                    .foregroundStyle(.black)
                Spacer(minLength: 5)
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
