//
//  RegistrationService.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import Foundation
import Combine

class RegistrationService {
    func registerUser(user: User) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                promise(.success(true))
            }
        }
        .eraseToAnyPublisher()
    }
}
