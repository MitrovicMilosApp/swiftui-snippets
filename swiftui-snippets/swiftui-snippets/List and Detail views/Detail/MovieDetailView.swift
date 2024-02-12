//
//  MovieDetailView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import SwiftUI

struct MovieDetailView: View {
    var viewModel: Movie
    var body: some View {
        HStack {
            Spacer(minLength: 20)
            ScrollView {
                VStack(spacing: 20) {
                    Spacer(minLength: 30)
                    Image(viewModel.imageTitle, bundle: nil)
                        .resizable()
                        .scaledToFit()
                    Text(viewModel.title)
                        .font(.largeTitle)
                    Text(viewModel.year)
                        .font(.title)
                    MovieRatingView(rate: viewModel.rating)
                    Text(viewModel.description)
                        .font(.subheadline)
                    Spacer(minLength: 30)
                }
                
                
            }
            .scrollIndicators(.hidden)
            Spacer(minLength: 20)
        }
    }
}
let godfather = Movie(title: "The Godfather",
                      description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
                      year: "1972",
                      rating: 9,
                      imageTitle: "thegodfather",
                      id: UUID())
#Preview {

    MovieDetailView(viewModel: godfather)
}

