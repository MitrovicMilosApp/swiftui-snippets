//
//  BarGraphView.swift
//  swiftui-snippets
//
//  Created by Milos Mitrovic on 20.2.24..
//

import SwiftUI
import Charts

struct BarGraphView: View {
    var period: [GraphData] {
        var data: [GraphData] = []
        for i in 0..<50 {
            data.append(GraphData(order: String(i), value: Int.random(in: 0..<200)))
        }
        return data
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                GroupBox(label: Text("Bar Chart")) {
                    ScrollView(.horizontal) {
                        Spacer()
                        Chart(period) {
                            BarMark(
                                x: .value("Order", $0.order),
                                y: .value("Value", $0.value),
                                width: .fixed(10)
                            )
                        }
                        .frame(width: max(geometry.size.width, CGFloat(period.count) * 20), height: 300)
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    BarGraphView()
}
