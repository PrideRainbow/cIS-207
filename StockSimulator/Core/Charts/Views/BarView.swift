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
    var totalHeight: Double 