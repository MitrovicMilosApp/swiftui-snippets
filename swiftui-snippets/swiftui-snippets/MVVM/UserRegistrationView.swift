//
//  UserRegistrationView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import SwiftUI

struct UserRegistrationView: View {
    @ObservedObject var viewModel = UserRegistrationViewModel()
    @State private var navigateToNextScreen = false
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
                            Task {
                                let response = await viewModel.register()
                                DispatchQueue.main.async {
                                    animateProgressView = false
                                    navigateToNextScreen = response
                                }
                            }
                        }) {
                            Text("Register")
                        }
                        .disabled(!viewModel.isFormValid)
                        
                    }
                }
                .navigationTitle("Register")
                .navigationDestination(isPresented: $navigateToNextScreen) {
                    NextView()
                }
                
            }
            if animateProgressView {
                ProgressView()
            }
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
