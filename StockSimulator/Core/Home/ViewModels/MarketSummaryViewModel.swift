//
//  MarketSummaryViewModel.swift
//  StockSimulator
//
//  Created by Christopher Walter on 9/9/22.
//

import Foundation
import SwiftUI

class MarketSummaryViewModel: ObservableObject
{
    @Published var marketData: [MarketSummary] = []
    
    @Published var snpMarketStats: [StatisticModel] = [] // this will display S&P market highlights on homeview
    @Published var dowMarketStats: [StatisticModel] = [] // this will display dow market highlights on homeview
    @Published var nasdaqMarketStats: [StatisticModel] = [] // this will display nasdaq market highlights on homeview
    
  