//
//  RegistrationService.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import Foundation

class RegistrationService {
    func registerUser(user: User) async -> Bool {
        // Simulate network request delay
        do {
            try await Task.sleep(nanoseconds:  1_000_000_000 / 2) 
            return true
        } catch {
            return false
        }
    }
}
