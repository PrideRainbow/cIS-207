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
            return minValue
        }
        else {
            return maxValue - minValue
        }
    }
    
   
    var body: some View {
        let barHeight = totalHeight / range * abs(value)
        let negativesHeight = minValue < 0 ? (-1 * minValue / range * totalHeight): 0
        let positivesHeight = maxValue > 0 ? abs(maxValue / range * totalHeight): 0
   