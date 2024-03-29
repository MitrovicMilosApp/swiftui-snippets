//
//  UserRegistrationViewModel.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import Foundation
import Combine

class UserRegistrationViewModel: ObservableObject {
    // Input
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Output
    @Published var isFormValid = false  
    @Published var registrationSuccessful = false
    
    private var registrationService = RegistrationService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isNameValidPublisher, isEmailValidPublisher, isPasswordValidPublisher)
            .map { nameIsValid, emailIsValid, passwordIsValid in
                return nameIsValid && emailIsValid && passwordIsValid
            }
            .eraseToAnyPublisher()
    }
    
    private var isNameValidPublisher: AnyPublisher<Bool, Never> {
        $name
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 3 }
            .eraseToAnyPublisher()
    }
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.contains("@") && $0.contains(".") }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 6 }
            .eraseToAnyPublisher()
    }
    
    func register() {
        let newUser = User(name: name, email: email, password: password)
        registrationService.registerUser(user: newUser)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break 
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] success in
                self?.registrationSuccessful = success
            })
            .store(in: &cancellables)
    }
}

