//
//  UserRegistrationView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import SwiftUI

struct UserRegistrationView: View {
    @ObservedObject var viewModel = UserRegistrationViewModel()
    @State private var animateProgressView = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    Section(header: Text("User Info")) {
                        TextField("Name", text: $viewModel.name)
                        TextField("Email", text: $viewModel.email)
                        SecureField("Password", text: $viewModel.password)
                    }
                    
                    Section {
                        Button(action: {
                            animateProgressView = true
                            viewModel.register()
                        }) {
                            Text("Register")
                        }
                        .disabled(!viewModel.isFormValid)
                        
                    }
                }
                .navigationTitle("Register")
                .navigationDestination(isPresented: $viewModel.registrationSuccessful) {
                    NextView()
                }
                
            }
            if animateProgressView {
                ProgressView()
            }
        }
        .onChange(of: viewModel.registrationSuccessful) { oldValue, newValue in
            animateProgressView = false
        }
    }
}

#Preview {
    UserRegistrationView()
}

struct NextView: View {
    var body: some View {
        Text("Registration Successful!")
    }
}
