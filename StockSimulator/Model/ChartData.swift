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
    
//    va