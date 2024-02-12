//
//  MovieRatingView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 12.2.24..
//

import SwiftUI

struct MovieRatingView: View {
    var rate: Int
    
    func starType(for index: Int) -> String {
         let fullStars = rate / 2
         let halfStar = rate % 2
         
         if index < fullStars {
             return "star.fill"
         } else if index == fullStars && halfStar != 0 {
             return "star.leadinghalf.filled"
         } else {
             return "star"
         }
     }
    
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: starType(for: index))
                    .foregroundStyle(.yellow)
            }
        }
    }
    

}

#Preview {
    MovieRatingView(rate: 9)
}
