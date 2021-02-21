//
//  MarketSummaryRow.swift
//  StockSimulator
//
//  Created by Christopher Walter on 6/19/22.
//

import SwiftUI

struct MarketSummaryRow: View {
    
    var marketSummary: MarketSummary
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(marketSummary.wrappedName)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(marketSummary.symbol)
                    .font(.subheadline)
                Text(marketSummary.regularMarketTime.fmt)

            }
  