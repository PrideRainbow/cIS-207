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
            Spacer()
            VStack(alignment: .leading) {
                Text(marketSummary.market)
                Text(marketSummary.quoteType)
            }
            .font(.body)
            Spacer()
            VStack(alignment: .trailing) {
                Text(marketSummary.regularMarketPrice.fmt)
                HStack {
                    Image(systemName: marketSummary.regularMarketChange.raw >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    Text(marketSummary.regularMarketChangePercent.fmt)
                }
                
            }
         