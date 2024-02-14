//
//  ScrollToOpen.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 14.2.24..
//

import SwiftUI
import Combine

struct ScrollToOpen: View {
    @State private var contentOffset: CGFloat = 0
    @State var items = [Movie]()
    
    let service = MoviesService()
    
    var body: some View {
        VStack {
            ZStack {
                Color(.blue)
                Text("OFFSET \(contentOffset)")
            }
            
            List(items, id: \.id) { movie in
                GeometryReader { geometry in
                    HStack {
                        Image(movie.imageTitle, bundle: nil)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipped()
                        VStack(alignment: .leading, spacing: 10) {
                            Text(movie.title)
                            Text(movie.year)
                            Text("Rating: \(movie.rating)")
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
                .frame(height: 120)
            }
            .listRowSpacing(10)
            .coordinateSpace(name: "ListView")
        }
        .onAppear(perform: {
            
            Task {
                var movies = await service.getMovies()
                movies.append(contentsOf: movies)
                movies.append(contentsOf: movies)

                DispatchQueue.main.async {
                    self.items = movies
                }
            }
        })
    }
}

#Preview {
    ScrollToOpen()
}
