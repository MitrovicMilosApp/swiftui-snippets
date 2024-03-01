//
//  DismissableView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

// A wrapper view that adds a tap gesture to dismiss the presented view
struct DismissableView<Content: View>: View {
    // Use the environment's presentation mode for dismissal
    @Environment(\.presentationMode) var presentationMode
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
}
