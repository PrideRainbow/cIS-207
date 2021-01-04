//
//  BarView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 8/27/22.
//

import SwiftUI

struct BarView: View {
    var name: String
    var value: Double // estimate
    var maxValue: Double
    var minValue: Double
    var totalHeight: Double // total height of graph
    
    var color: Color

    var range: Double {
        if minValue >= 0 {
            return maxValue
        }
        else if maxValue <= 0 {
            