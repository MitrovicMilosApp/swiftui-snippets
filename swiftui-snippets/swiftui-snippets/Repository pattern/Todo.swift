//
//  Todo.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 29.2.24..
//

import Foundation

struct Todo: Identifiable, Codable {
    let id: UUID
    let text: String
    var done: Bool
    var date = Date()
}
