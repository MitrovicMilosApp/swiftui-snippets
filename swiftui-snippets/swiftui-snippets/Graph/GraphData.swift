//
//  GraphData.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 20.2.24..
//

import Foundation

struct GraphData: Identifiable {
    let id = UUID()
    let order: String
    let value: Int
    
    init(order: String, value: Int) {
        self.value = value
        self.order = order
    }
}
