//
//  ScrollToOpen.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 14.2.24..
//

import SwiftUI
import Combine

struct ScrollToOpen: View {
    struct Constants {
        static let openHeight: CGFloat = 400
        static let closedHeight: CGFloat = 120
    }
    
    @State private var topViewHeight: CGFloat = Constants.openHeight
    @State var items = [Movie]()
    @State var isAnimating = false
    @State var selectedMovie: Movie?
    
    var body: some View {
        VStack {
            ZStack {
                Color.white.frame(height: topViewHeight)
                if let selectedMovie = selectedMovie {
                    HStack(spacing: 20) {
                        Spacer(minLength: Constants.closedHeight)
                        VStack {
                            Text("\(selectedMovie.title), \(selectedMovie.year)")
                        }
                        Spacer()
                    }
                    HStack {
                        VStack {
                            Image(selectedMovie.imageTitle)
                                .resizable()
                                .scaledToFill()
                                .frame(width: getTopViewWidth(fromHeight: topViewHeight), height: topViewHeight, alignment: .topLeading)
                                .clipped()
                        }
                        Spacer()
                    }
                } else {
                    Text("Select a movie")
                }
            }
            .animation(.easeOut(duration: 0.5), value: topViewHeight)

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
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .frame(height: 120)
                    .onTapGesture {
                        selectedMovie = movie
                    }
                }
            }
            .onPreferenceChange(ViewOffsetKey.self) { value in
                animateTopView(value: value)
            }
        }
        .background(Color.gray.opacity(0.3))
        .onAppear(perform: loadMovies)
    }
    
    func loadMovies() {
        Task {
            var movies = await MoviesService().getMovies()
            movies.append(contentsOf: movies)
            movies.append(contentsOf: movies)
            self.items = movies
        }
    }
    
    func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getTopViewWidth(fromHeight height: CGFloat) -> CGFloat {
        if height == Constants.openHeight {
            return getDeviceWidth()
        } else {
            return 120
        }
    }
    
    func animateTopView(value: CGFloat) {
        if topViewHeight == Constants.closedHeight && value >  Constants.closedHeight {
            guard !isAnimating else { return }
            isAnimating = true
            withAnimation {
                topViewHeight = Constants.openHeight
            } completion: {
                isAnimating = false
            }
            
        } else if topViewHeight == Constants.openHeight && value < Constants.openHeight {
            guard !isAnimating else { return }
            isAnimating = true
            withAnimation {
                topViewHeight = Constants.closedHeight
            } completion: {
                isAnimating = false
            }
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
