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
    let exchangeTimezoneShortName: