//
//  MarketSummary.swift
//  StockSimulator
//
//  Created by Christopher Walter on 6/13/22.
//

import Foundation
import SwiftUI

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


// MARK: - Welcome
struct CompleteMarketSummary: Codable {
    let marketSummaryResponse: MarketSummaryResponse
}

// MARK: - MarketSummaryResponse
struct MarketSummaryResponse: Codable {
    let error: JSONNull?
    let result: [MarketSummary]
}

// MARK: - Result
struct MarketSummary: Codable {
    let exchange: String
    let exchangeDataDelayedBy: Int
    let exchangeTimezoneName: String?
    let exchangeTimezoneShortName: String?
//    let exchangeTimezoneName: ExchangeTimezoneName?
//    let exchangeTimezoneShortName: ExchangeTimezoneShortName?
    let firstTradeDateMilliseconds: Int
    let fullExchangeName: String
    let gmtOffSetMilliseconds: Int
    let language: Language
    let market, marketState: String
    let priceHint: Int?
    let quoteSourceName: String?
    let quoteType: String
    let region: Region
    let regularMarketChange, regularMarketChangePercent, regularMarketPreviousClose, regularMarketPrice: RegularMarket
    let regularMarketTime: RegularMarket
    let shortName: String?
    let sourceInterval: Int
    let symbol: String
    let tradeable, triggerable: Bool
    let contractSymbol, headSymbol: Bool?
    let headSymbolAsString, currency, longName: String?
//    var id = UUID()
    
    var wrappedName: String {
        if let name = shortName
        {
            return name
        } else {
            return fullExchangeName
        }
    }
    
    // this will be filled with Sample MarketData
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
    //            "pric