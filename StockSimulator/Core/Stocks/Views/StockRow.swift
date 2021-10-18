//
//  StockRow.swift
//  StockSimulator
//
//  Created by Christopher Walter on 2/12/22.
//

import SwiftUI

struct StockRow: View {
    
    var stock: Stock
    
    var body: some View {
        HStack (alignment: .firstTextBaseline){
            VStack(alignment: .leading){
                Text(stock.symbol ?? "Unknown")
                    .font(.title)
                    .fontWeight(.bold)
                Text(stock.wrappedDisplayName)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack {
                Text(String(format: "$%.2f", stock.regularMarketPrice))
                                .font(.title)
                HStack {
                    Text(stock.regularMarketChangeFormatted)
                    
                    Text(stock.regularMarketChangePercentFormatted)
                }
      