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
        
        guard let quoteSummary = quoteSummary, let keyStats = quoteSummary.defaultKeyStatistics else {
            return
        }
        


        // look at future earnings, PEG ratio, PE Ratio, 200 Day Average, 50 Day Average. Dividend Percent, average analyst rating
        
        var total = 0.0
        
        // Dividend Score will be worth 10 points If dividend 10% or higher, stock gets a 10, otherwise stock gets the dividend rate.
        let dividendRate = (stockSnapshot.trailingAnnualDividendYield ?? 0) * 100
        
        total += (dividendRate >= 10) ? 10 : dividendRate

        // average analyst rating
        // The weighting of the ratings is 1 for buy, 2 for outperform, 3 for hold, 4 for underperform and 5 for sell.
        
        
//        let epsForward = stockSnapshot.epsForward ?? 0
//        let eps = stockSnapshot.epsTrailingTwelveMonths ?? 0
//        print("epsForward: \(epsForward), eps: \(eps)")
//        let growth = epsForward - eps
//        total += growth
        
        
        stockRating = total
        
    }
    
    func loadStockRecommendations() {
        APICaller.shared.getReccomendationsBySymbol(symbol: self.symbol) { result in
            switch result {
            case .stockReccomendations(let array):
                var result : [RecommendedSymbol] = []
                for r in array {
                    result.append(contentsOf: r.recommendedSymbols)
                }
                DispatchQueue.main.async {
                    self.stockRecommendations = result
                }
            case .failure(let string):
                print("Error: " + string)
            default:
                print("Found unexpected result when loading stock reccomendations")
            }
        }
    }
    
    func loadOverviewStats()
    {
        guard let stockSnapshot = stockSnapshot else {
            return
        }
        if stockSnapshot.quoteType == "CRYPTOCURRENCY"
        {
            loadCryptoStats()
        }
        else {
            loadStockStats()
            calculateStockRating()
        }
        
    }
    
    private func loadStockStats()
    {
        guard let stockSnapshot = stockSnapshot else {
            return
        }

        let regularMarketPrice = stockSnapshot.regularMarketPrice.asCurrencyWith6Decimals()
        let priceStat = StatisticModel(title: "Price", value: regularMarketPrice)
        let previousCloseStat = StatisticModel(title: "Previous Close", value: stockSnapshot.regularMarketPreviousClose.asCurrencyWith6Decimals())
        let marketCap = Double(stockSnapshot.marketCap ?? 0).formattedWithAbbreviations()
        let marketCapStat = StatisticModel(title: "Market Cap", value: marketCap)
        let open = stockSnapshot.regularMarketOpen.asCurrencyWith6Decimals()
        let openStat = StatisticModel(title: "Open", value: open)
        let avgVolume3Month = Double(stockSnapshot.averageDailyVolume3Month).formattedWithAbbreviations()
        let avgVolume3MonthStat = StatisticModel(title: "Average Volume 3 Months", value: avgVolume3Month)
        let avgVolume10Day = Double(stockSnapshot.averageDailyVolume10Day).formattedWithAbbreviations()
        let avgVolume10DayStat = StatisticModel(title: "Average Volume 10 Day", value: avgVolume10Da