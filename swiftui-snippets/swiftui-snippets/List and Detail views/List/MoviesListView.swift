//
//  MoviesListView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel = MoviesListViewModel()
    var body: some View {
        NavigationStack {
            List(viewModel.movies, id: \.id) { item in
                NavigationLink(value: item) {
                    Text(item.title)
                }
                .navigationDestination(for: Movie.self, destination: { movie in
                    MovieDetailView(viewModel: movie)
                })
            }
        }
        .navigationTitle("Movies")
        .onAppear(perform: {
            viewModel.requestMovies()
        })
    }
}

#Preview {
    MoviesListView()
}
