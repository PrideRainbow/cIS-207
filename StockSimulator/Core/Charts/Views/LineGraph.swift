//
//  LineGraph.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/24/22.
//

import SwiftUI

struct LineGraph: Shape {
    // These are the normalized Data Points between 0 and 1
    var dataPoints: [Double]

    func path(in rect: CGRect) -> Path {

        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1 - CGFloat(