//
//  GesturesDemoView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 13.2.24..
//

import SwiftUI

struct GesturesDemoView: View {
    @State private var tapCount = 0
    @State private var longPressCount = 0
    @GestureState private var dragAmount = CGSize.zero
    @GestureState private var pinchScale: CGFloat = 1.0
    @GestureState private var isDetectingLongPress = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            // Tap Gesture
            Text("Tap me! \nTaps: \(tapCount)")
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .onTapGesture {
                    tapCount += 1
                }
            
            // Long Press Gesture
            Text("Long Press me! \nLong Presses: \(longPressCount)")
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .onLongPressGesture {
                    longPressCount += 1
                }
            
            Text(getLongPressText())
                .padding()
                .background(Color.cyan)
                .cornerRadius(10)
                .gesture(
                    LongPressGesture(minimumDuration: 3)
                        .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                            gestureState = currentState
                        }
                )
            
            // Drag Gesture
            Text("Drag me!")
                .padding()
                .background(Color.orange)
                .cornerRadius(10)
                .offset(dragAmount)
                .gesture(
                    DragGesture().updating($dragAmount) { value, state, transaction in
                        state = value.translation
                    }
                )
            
            // Pinch to Zoom Gesture
            Text("Pinch me!")
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
                .scaleEffect(pinchScale)
                .gesture(
                    MagnificationGesture()
                        .updating($pinchScale) { currentState, gestureState, _ in
                            gestureState = currentState
                        }
                )
            Spacer()
        }
        .padding()
        .animation(.spring(), value: dragAmount)
        .animation(.spring(), value: pinchScale)
    }
    
    func getLongPressText() -> String {
        if isDetectingLongPress {
            return "Long Press me! \nLong Press Detected!"
        } else {
            return "Long Press me!"
        }
    }
}

#Preview {
    GesturesDemoView()
}
