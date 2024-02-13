//
//  DismissableView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

// A wrapper view that adds a swipe down gesture to dismiss the presented view
struct DismissableView<Content: View>: View {
    // Use the environment's presentation mode for dismissal
    @Environment(\.presentationMode) var presentationMode
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .gesture(DragGesture().onEnded { value in
                // Check for a downward swipe
                if value.translation.height > 50 && value.predictedEndTranslation.height > 0 {
                    presentationMode.wrappedValue.dismiss()
                }
            })
    }
}
