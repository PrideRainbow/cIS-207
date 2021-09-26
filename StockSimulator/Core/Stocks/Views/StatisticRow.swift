//
//  StatisticRow.swift
//  StockSimulator
//
//  Created by Christopher Walter on 8/26/22.
//

import SwiftUI

struct StatisticRow: View {
    
    let stat: StatisticModel
    
    var body: some View {
        HStack(spacing: 15) {
            Text(stat.title)
                .font(.caption)
                .lineLimit(2)
//                .foregroundColor(Color.theme.secondaryText)
            Spacer()
            
            HStack {
         