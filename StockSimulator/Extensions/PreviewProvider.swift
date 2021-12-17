
//
//  PreviewProvider.swift
//  StockSimulator
//
//  Created by Christopher Walter on 5/18/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    

//    let homeVM = HomeViewModel()
    let stockVM = StocksViewModel()
    let chartVM = ChartViewModel()
    let marketsummaryVM = MarketSummaryViewModel()
    
    let dataController = DataController()
    
    let stat1 = StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
    let stat2 = StatisticModel(title: "Total Volume", value: "$1.23Tr")
    let stat3 = StatisticModel(title: "Portfolio Value", value: "$50.4K", percentageChange: -12.34)
    
    let earnings1 = EarningsModel(title: "3Q2021", actual: 2.1, estimate: 1.89) // gain, beat
    let earnings2 = EarningsModel(title: "4Q2021", actual: -0.4, estimate: -0.6) // loss, miss
    let earnings3 = EarningsModel(title: "1Q2022", actual: 1.27, estimate: 1.4) // gain, miss
    let earnings4 = EarningsModel(title: "2Q2022", actual: -0.2, estimate: -0.11) // loss, beat
    let earnings5 = EarningsModel(title: "3Q2022", actual: 0.4, estimate: 0.4) // gain, tie
    let earnings6 = EarningsModel(title: "4Q2022", actual: -0.8, estimate: -0.8) // loss, tie
    let earnings7 = EarningsModel(title: "1Q2023", estimate: 1.7) // estimate only
    
    var earningsData: [EarningsModel] {
        return [earnings1, earnings2, earnings3, earnings4, earnings5, earnings6, earnings7]
    }
    
    var sampleTransaction: Transaction {
        let t = Transaction(context: dataController.container.viewContext)
        t.stock = sampleStock
        t.account = sampleAccount
        t.id = UUID()
        t.buyDate = Date()
        t.purchasePrice = 100
        t.numShares = 10
        t.isClosed = false
        t.costBasis = t.purchasePrice * t.numShares
        t.eventType = "BUY"
        
        return t
    }
    var sampleAccount: Account {
        let account = Account(context: dataController.container.viewContext)
        account.cash = 10000
        
        return account
    }
    
    var sampleStock: Stock {
        let context = dataController.container.viewContext
        
        let stock = Stock(context: context)
        stock.updateValuesFromStockSnapshot(snapshot: StockSnapshot()) // this is sample Apple information
//        stock.symbol = "TEST"
//        stock.displayName = "ABC STOCK"
//        stock.regularMarketPrice = 21.34
//        stock.regularMarketChange = 1.05
//        stock.regularMarketChangePercent = 0.12
        
        return stock
    }
//    func sampleAccount() -> Account
//    {
//        let account = Account(context: dataController.container.viewContext)
//        account.cash = 10000
//
//        return account
//    }
    
    var sampleWatchlist: Watchlist {
        let context = dataController.container.viewContext
        let watchlist = Watchlist(context: context)
        watchlist.name = "Sample"
        
        let stock = Stock(context: context)
        stock.symbol = "TEST"
        stock.displayName = "ABC STOCK"
        stock.regularMarketPrice = 21.34
        
        watchlist.addToStocks(stock)
        
        let stock2 = Stock(context: context)
        stock2.symbol = "TEST2"
        stock2.displayName = "DEF STOCK"
        stock2.regularMarketPrice = 56.78
        
        watchlist.addToStocks(stock2)
        
        return watchlist
    }
    
//    func sampleWatchlist() -> Watchlist
//    {
//        let context = dataController.container.viewContext
//        let watchlist = Watchlist(context: context)
//        watchlist.name = "Sample"
//
//        let stock = Stock(context: context)
//        stock.symbol = "TEST"
//        stock.displayName = "ABC STOCK"
//        stock.regularMarketPrice = 21.34
//
//        watchlist.addToStocks(stock)
//
//        let stock2 = Stock(context: context)
//        stock2.symbol = "TEST2"
//        stock2.displayName = "DEF STOCK"
//        stock2.regularMarketPrice = 56.78
//
//        watchlist.addToStocks(stock2)
//
//        return watchlist
//    }
    
//    func sampleStock() -> Stock {
//        let context = dataController.container.viewContext
//
//        let stock = Stock(context: context)
//        stock.updateValuesFromStockSnapshot(snapshot: StockSnapshot()) // this is sample Apple information
////        stock.symbol = "TEST"
////        stock.displayName = "ABC STOCK"
////        stock.regularMarketPrice = 21.34
////        stock.regularMarketChange = 1.05