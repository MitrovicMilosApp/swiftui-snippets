//
//  RotatingImageView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct RotatingImageView: View {
    @State private var rotationAngle: Angle = .zero
    @State private var finalAngle: Angle = .zero

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Use two fingers to rotate the image")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Spacer()
                    Image("thegodfather")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .rotationEffect(rotationAngle)
                        .gesture(
                            RotationGesture()
                                .onChanged { angle in
                                    self.rotationAngle = self.finalAngle + angle
                                }
                                .onEnded { angle in
                                    self.finalAngle = self.rotationAngle
                                }
                        )
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    RotatingImageView()
}
