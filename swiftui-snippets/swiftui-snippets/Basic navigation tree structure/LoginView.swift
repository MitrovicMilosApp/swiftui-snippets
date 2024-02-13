//
//  LoginView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("Login Screen")
            Button("Log In") {
                isLoggedIn = true
            }
            Spacer()
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
