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
                      