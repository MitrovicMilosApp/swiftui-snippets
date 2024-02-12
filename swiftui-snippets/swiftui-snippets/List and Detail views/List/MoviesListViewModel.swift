//
//  MoviesListViewModel.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import Foundation
import Combine

class MoviesListViewModel: ObservableObject {
    
    // Output
    @Published var movies: [Movie] = []
    
    private var service = MoviesService()
    
    // Input
    func requestMovies() {
        Task {
            let movies = await service.getMovies()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.movies = movies
            }
        }
    }
}
