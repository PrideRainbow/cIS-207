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

    func path(in rect: CGRect) -> Path 