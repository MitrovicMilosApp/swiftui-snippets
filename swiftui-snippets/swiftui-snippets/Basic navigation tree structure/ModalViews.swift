//
//  ModalViews.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct FullScreenModalView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Full Screen Modal View")
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
}

struct ModalSheetView: View {
    var body: some View {
        Text("Modal Sheet View")
    }
}

struct DetailView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Detail View")
            Button {
                dismiss()
            } label: {
                Text("Pop view (also dismiss)")
            }
        }
    }
}

#Preview {
    DetailView()
}
