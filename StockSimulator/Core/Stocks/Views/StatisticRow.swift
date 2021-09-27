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
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:(stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text((stat.isPercentChange ?? true) ? (stat.percentageChange?.asPercentString() ?? ""): (stat.percentageChange?.formattedWithAbbreviations() ?? ""))
                    .font(.caption)
                    .bold()
                    .lineLimit(2)
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : 