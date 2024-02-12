//
//  MoviesService.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import Foundation

class MoviesService {
    func getMovies() async -> [Movie] {
        // Simulate network request delay
        do {
            try await Task.sleep(nanoseconds:  1_000_000_000 / 2)
            let godfather = Movie(title: "The Godfather",
                                  description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
                                  year: "1972",
                                  rating: 9,
                                  imageTitle: "thegodfather",
                                  id: UUID())
            let purge = Movie(title: "The Purge",
                              description: "A wealthy family is held hostage for harboring the target of a murderous syndicate during the Purge, a 12-hour period in which any and all crime is legal.",
                              year: "2013",
                              rating: 5,
                              imageTitle: "thepurge",
                              id: UUID())
            let sharknado = Movie(title: "Sharknado",
                                  description: "When a freak hurricane swamps Los Angeles, nature's deadliest killer rules sea, land, and air as thousands of sharks terrorize the waterlogged populace.",
                                  year: "2013",
                                  rating: 3,
                                  imageTitle: "sharknado",
                                  id: UUID())
            let room = Movie(title: "The Room",
                             description: "In San Francisco, an amiable banker's seemingly perfect life is turned upside down when his deceitful fiancée embarks on an affair with his best friend.",
                             year: "2003",
                             rating: 4,
                             imageTitle: "theroom",
                             id: UUID())
            return [godfather, purge, sharknado, room]
        } catch {
            return []
        }
    }
}
