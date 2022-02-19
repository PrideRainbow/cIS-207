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
    init()
    {
        print("init() called on chartData it is MockData")
        adjclose = [165.1199951171875,
                    163.1999969482422,
                    166.5599975585938,
                    166.2299957275391,
                    163.1699981689453,
                    159.3000030517578,
                    157.4400024414062,
                    162.9499969482422,
                    158.5200042724609,
                    154.7299957275391,
                    150.6199951171875,
                    155.0899963378906,
                    159.5899963378906,
                    160.6199951171875,
                    163.9799957275391,
                    165.3800048828125,
                    168.8200073242188,
                    170.2100067138672,
                    174.0700073242188,
                    174.7200012207031,
                    175.6000061035156,
                    178.9600067138672,
                    177.7700042724609]
        close = [165.1199951171875,
                 163.1999969482422,
                 166.5599975585938,
                 166.2299957275391,
                 163.1699981689453,
                 159.3000030517578,
                 157.4400024414062,
                 162.9499969482422,
                 158.5200042724609,
                 154.7299957275391,
                 150.6199951171875,
                 155.0899963378906,
    