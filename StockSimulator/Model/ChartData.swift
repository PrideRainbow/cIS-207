//
//  ChartData.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/22/22.
//

import Foundation


struct MetaData: Codable {
    var chartPreviousClose: Double
    var currency: String
    var dataGranularity: String
    var exchangeName: String
    var exchangeTimezoneName: String
    var firstTradeDate: Double
    var gmtoffset: Int
    var instrumentType: String
    var priceHint: Int
    var range: String
    var regularMarketPrice: Double
    var regularMarketTime: Double
    var symbol: String
    var timezone: String
    var validRanges: [String]
    
    var currentTradingPeriod: CurrentTradingPeriod?
    
//    var post: CurrentTradingPeriod?
//    var pre: CurrentTradingPeriod?
//    var regular: CurrentTradingPeriod?
    
    init()
    {
        chartPreviousClose = 164.85
        currency = "USD"
        dataGranularity = "1d"
        exchangeName = "NY"
        exchangeTimezoneName = "GMT"
        firstTradeDate = 345479400
        gmtoffset = -14400
        instrumentType = "EQUITY"
        priceHint = 2
        range = "1m"
        regularMarketPrice = 177.77
        regularMarketTime = 1648670404
        symbol = "AAPL"
        timezone = "GMT"
        validRanges = ["1d",
                       "5d",
                       "1mo",
                       "3mo",
                       "6mo",
                       "1y",
                       "2y",
                       "5y",
                       "10y",
                       "ytd",
                       "max"]
        
//        post = CurrentTradingPeriod(end: 0, gmtoffset: 0, start: 0, timezone: "GMT")
//        pre = CurrentTradingPeriod(end: 0, gmtoffset: 0, start: 0, timezone: "GMT")
//        regular = CurrentTradingPeriod(end: 0, gmtoffset: 0, start: 0, timezone: "GMT")
    }
}

struct ChartData: Codable {
    
    var adjclose: [Double?]
    var close: [Double?] // sometimes null comes through with the data
    var high: [Double?]
    var low: [Double?]
    var open: [Double?]
    var volume: [Int?]
    var timestamp: [Int]
    var events: Events?
    
    var wrappedClose: [Double] {
        var result = [Double]()
        for i in close {
            if let val = i
            {
                result.append(val)
            }
        }
        return result
    }
    
    var wrappedadjclose: [Double] {
        var result = [Double]()
        for i in adjclose {
            if let val = i
            {
                result.append(val)
            }
        }
        return result
    }
    
    var wrappedhigh: [Double] {
        var result = [Double]()
        for i in high {
            if let val = i
            {
                result.append(val)
            }
        }
        return result
    }
    
    var wrappedlow: [Double] {
        var result = [Double]()
        for i in low {
            if let val = i
            {
                result.append(val)
            }
        }
        return result
    }
    
    var wrappedopen: [Double] {
        var result = [Double]()
        for i in open {
            if let val = i
            {
                result.append(val)
            }
        }
        return result
    }
    
    var wrappedvolume: [Int] {
        var result = [Int]()
        for i in volume {
            if let val = i
            {
                result.append(val)
            }
        }
        return result
    }
    
    // this is a helper function for 
    func priceAtOpenOnDate(date: Int) -> Double?
    {
        if let location = timestamp.firstIndex(of: date) {
            return open[location]
        }
        else {
            return nil
        }
    }
    
    var metaData: MetaData?
    
    var errorMessage: String?
    
    // this is sample 1 month data for AAPL on 3/30/22 // this is mockData