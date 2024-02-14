//
//  ScrollToOpen.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 14.2.24..
//

import SwiftUI
import Combine

struct ScrollToOpen: View {
    @State private var topViewHeight: CGFloat = 250
    @State private var offset: CGFloat = 0
    @State var items = [Movie]()
    @State var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.blue.frame(height: topViewHeight)
                    .animation(.easeOut, value: topViewHeight)
                
                Text("Offset: \(offset)")
            }
            
            ScrollView {
                GeometryReader { geometry in
                    Color.clear.preference(key: ViewOffsetKey.self, value: geometry.frame(in: .global).minY)
                }
                .frame(height: 0)
                
                ForEach(items, id: \.id) { movie in
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
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .frame(height: 120)
                    .presentationCornerRadius(10)
                    .clipped()
                }
            }
            .onPreferenceChange(ViewOffsetKey.self) { value in

                offset = value
                if topViewHeight == 100 && value > 50 {
                    guard !isAnimating else { return }
                    isAnimating = true
                    withAnimation {
                        topViewHeight = 250
                    } completion: {
                        isAnimating = false
                    }
                    
                } else if topViewHeight == 250 && value < 10 {
                    guard !isAnimating else { return }
                    isAnimating = true
                    withAnimation {
                        topViewHeight = 100
                    } completion: {
                        isAnimating = false
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.3))
        .onAppear(perform: loadMovies)
    }
    
    func loadMovies() {
        Task {
            var movies = await MoviesService().getMovies()
            movies.append(contentsOf: movies)
            self.items = movies
        }
    }
}

#Preview {
    ScrollToOpen()
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
