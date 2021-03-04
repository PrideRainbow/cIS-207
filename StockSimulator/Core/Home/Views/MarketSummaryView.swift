//
//  MarketSummaryView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 6/19/22.
//

import SwiftUI

struct MarketSummaryView: View {
    
    var marketSummary: MarketSummary
    
    @ObservedObject var vm = StocksViewModel()
    
    var body: some View {
        VStack {
            Section(header: Text("Summary")) {
                HStack {
                    Text("Symbol:")
                    Spacer()
                    Text(marketSummary.symbol)
                        .foregroundColor(Color.theme.secondaryText)
                }
            }
            VStack {
                HStack(alignment: .top){
                    VStack(alignment: .leading) {
                        Text("Symbol: \(marketSummary.symbol)")
                        Text("Market Time: \(marketSummary.regularMarketTime.fmt)")
                        Text("Previous Close: \(marketSummary.regularMarketPreviousClose.fmt)")
                        Text("Market: \(marketSummary.market)")
                        Text("Quote Type: \(marketSummary.quoteType)")
                        
          