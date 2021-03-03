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
      