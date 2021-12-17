
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
////        stock.regularMarketChangePercent = 0.12
//
//        return stock
//    }
    
    
    
    
//    Sample Market Summary Response:
//
//    {
//      "marketSummaryResponse": {
//        "error": null,
//        "result": [
//          {
//            "exchange": "SNP",
//            "exchangeDataDelayedBy": 0,
//            "exchangeTimezoneName": "America/New_York",
//            "exchangeTimezoneShortName": "EDT",
//            "firstTradeDateMilliseconds": -1325583000000,
//            "fullExchangeName": "SNP",
//            "gmtOffSetMilliseconds": -14400000,
//            "language": "en-US",
//            "market": "us_market",
//            "marketState": "POST",
//            "priceHint": 2,
//            "quoteSourceName": "Delayed Quote",
//            "quoteType": "INDEX",
//            "region": "US",
//            "regularMarketChange": {
//              "fmt": "67.12",
//              "raw": 67.11987
//            },
//            "regularMarketChangePercent": {
//              "fmt": "2.01%",
//              "raw": 2.0144987
//            },
//            "regularMarketPreviousClose": {
//              "fmt": "3,331.84",
//              "raw": 3331.84
//            },
//            "regularMarketPrice": {
//              "fmt": "3,398.96",
//              "raw": 3398.96
//            },
//            "regularMarketTime": {
//              "fmt": "5:12PM EDT",
//              "raw": 1599685935
//            },
//            "shortName": "S&P 500",
//            "sourceInterval": 15,
//            "symbol": "^GSPC",
//            "tradeable": false,
//            "triggerable": false
//          },
//          {
//            "exchange": "DJI",
//            "exchangeDataDelayedBy": 0,
//            "exchangeTimezoneName": "America/New_York",
//            "exchangeTimezoneShortName": "EDT",
//            "firstTradeDateMilliseconds": 475857000000,
//            "fullExchangeName": "DJI",
//            "gmtOffSetMilliseconds": -14400000,
//            "language": "en-US",
//            "market": "us_market",
//            "marketState": "POST",
//            "priceHint": 2,
//            "quoteSourceName": "Delayed Quote",
//            "quoteType": "INDEX",
//            "region": "US",
//            "regularMarketChange": {
//              "fmt": "439.58",
//              "raw": 439.58008
//            },
//            "regularMarketChangePercent": {
//              "fmt": "1.60%",
//              "raw": 1.5984213
//            },
//            "regularMarketPreviousClose": {
//              "fmt": "27,500.89",
//              "raw": 27500.89
//            },
//            "regularMarketPrice": {
//              "fmt": "27,940.47",
//              "raw": 27940.47
//            },
//            "regularMarketTime": {
//              "fmt": "5:12PM EDT",
//              "raw": 1599685935
//            },
//            "shortName": "Dow 30",
//            "sourceInterval": 120,
//            "symbol": "^DJI",
//            "tradeable": false,
//            "triggerable": false
//          },
//          {
//            "exchange": "NIM",
//            "exchangeDataDelayedBy": 0,
//            "exchangeTimezoneName": "America/New_York",
//            "exchangeTimezoneShortName": "EDT",
//            "firstTradeDateMilliseconds": 34612200000,
//            "fullExchangeName": "Nasdaq GIDS",
//            "gmtOffSetMilliseconds": -14400000,
//            "language": "en-US",
//            "market": "us_market",
//            "marketState": "POST",
//            "priceHint": 2,
//            "quoteSourceName": "Delayed Quote",
//            "quoteType": "INDEX",
//            "region": "US",
//            "regularMarketChange": {
//              "fmt": "293.87",
//              "raw": 293.87402
//            },
//            "regularMarketChangePercent": {
//              "fmt": "2.71%",
//              "raw": 2.709093
//            },
//            "regularMarketPreviousClose": {
//              "fmt": "10,847.70",
//              "raw": 10847.7
//            },
//            "regularMarketPrice": {
//              "fmt": "11,141.56",
//              "raw": 11141.564
//            },
//            "regularMarketTime": {
//              "fmt": "5:15PM EDT",
//              "raw": 1599686159
//            },
//            "shortName": "Nasdaq",
//            "sourceInterval": 15,
//            "symbol": "^IXIC",
//            "tradeable": false,
//            "triggerable": false
//          },
//          {
//            "exchange": "WCB",
//            "exchangeDataDelayedBy": 20,
//            "exchangeTimezoneName": "America/New_York",
//            "exchangeTimezoneShortName": "EDT",
//            "firstTradeDateMilliseconds": 558279000000,
//            "fullExchangeName": "Chicago Options",
//            "gmtOffSetMilliseconds": -14400000,
//            "language": "en-US",
//            "market": "us_market",
//            "marketState": "POST",
//            "priceHint": 2,
//            "quoteType": "INDEX",
//            "region": "US",
//            "regularMarketChange": {
//              "fmt": "21.89",
//              "raw": 21.888916
//            },
//            "regularMarketChangePercent": {
//              "fmt": "1.45%",
//              "raw": 1.4548081
//            },
//            "regularMarketPreviousClose": {
//              "fmt": "1,504.59",
//              "raw": 1504.5913
//            },
//            "regularMarketPrice": {
//              "fmt": "1,526.48",
//              "raw": 1526.4802
//            },
//            "regularMarketTime": {
//              "fmt": "4:30PM EDT",
//              "raw": 1599683408
//            },
//            "shortName": "Russell 2000",
//            "sourceInterval": 15,
//            "symbol": "^RUT",
//            "tradeable": false,
//            "triggerable": false
//          },
//          {
//            "contractSymbol": false,
//            "exchange": "NYM",
//            "exchangeDataDelayedBy": 30,
//            "exchangeTimezoneName": "America/New_York",
//            "exchangeTimezoneShortName": "EDT",
//            "firstTradeDateMilliseconds": 967003200000,
//            "fullExchangeName": "NY Mercantile",
//            "gmtOffSetMilliseconds": -14400000,
//            "headSymbol": true,
//            "headSymbolAsString": "CL=F",
//            "language": "en-US",
//            "market": "us24_market",
//            "marketState": "REGULAR",
//            "quoteType": "FUTURE",