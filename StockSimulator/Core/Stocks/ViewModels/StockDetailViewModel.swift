//
//  StockDetailViewModel.swift
//  StockSimulator
//
//  Created by Christopher Walter on 7/27/22.
//

import Foundation
import SwiftUI
import Combine

class StockDetailViewModel: ObservableObject
{
    @Published var symbol: String = ""
//    @Published var stock: Stock? = nil
    
    @Published var overviewStatistics: [StatisticModel] = []
    
    @Published var stockSnapshot: StockSnapshot? = nil
    
    @Published var stockRating: Double = 0
    
    @Published var stockRecommendations: [RecommendedSymbol] = [] // this has an array of RecommendedSymbols
    
    @Published var quoteSummary: QuoteSummary? = nil
//    @Environment(\.managedObjectContext) var moc // CoreData
    
    @Published var earningsStatistics: [EarningsModel] = []

    init(stockSnapshot: StockSnapshot)
    {
        self.symbol = stockSnapshot.symbol
        
        self.stockSnapshot = stockSnapshot
        stockRecommendations = []
        loadOverviewStats()
        loadStockRecommendations()
        loadQuoteSummary(symbol: stockSnapshot.symbol)
    }
    
    init(symbol: String)
    {
        self.symbol = symbol
        reloadStockData(symbol: symbol)
        loadStockRecommendations()
        loadQuoteSummary(symbol: symbol)
        
    }
    
    func calculateStockRating() {
        
        guard let stockSnapshot = stockSnapshot else {
            return
        }
        
        guard let quoteSummary = quoteSummary, let k