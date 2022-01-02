
//
//  LineGraphView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 8/9/22.
//

import SwiftUI

struct LineGraphView: View {
    var data: [CGFloat]
    
    @State var currentPlot = ""
    
    @State var offset: CGSize = .zero
    
    @State var showPlot = false
    
    @State var translation: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count - 1)
            let maxPoint = (data.max() ?? 0) + 100
            let points = data.enumerated().compactMap {
                item -> CGPoint in
                // getting progress and multiplying with the height
                let progress = item.element / maxPoint
                
                let pathHeight = progress * height

                // width
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            ZStack {

                // Path...
                Path { path in
                    // drawing the points
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLines(points)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                .fill(
                    LinearGradient(colors: [
                        Color.theme.green,
                        Color.theme.red
                    ], startPoint: .leading, endPoint: .trailing)
                )
                
                // Path Background Coloring
                fillBG()
                .clipShape(
                    Path { path in
                        path.move(to: CGPoint.zero)
                        path.addLines(points)
                        path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                        path.addLine(to: CGPoint(x: 0, y: height))
                    }
                )
                .padding(.top, 12)
            }
            .overlay(
                // Drag indicator
                VStack(spacing: 0) {
                    Text(currentPlot)
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(Color.theme.green, in: Capsule())
                        .offset(x: translation < 10 ? 30: 0)
                        .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                    Rectangle()
                        .fill(Color.theme.green)
                        .frame(width: 1, height: 40)
                        .padding(.top)
                    Circle()
                        .fill(Color.theme.green)
                        .frame(width: 22, height: 22)
                        .overlay(
                            Circle()