//
//  Movie.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import Foundation

struct Movie: Hashable {
    let title: String
    let description: String
    let year: String
    let rating: Int
    let imageTitle: String
    let id: UUID
}
