//
//  StatisticModel.swift
//  StockSimulator
//
//  Created by Christopher Walter on 7/24/22.
//

import Foundation

struct StatisticModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    let isPercentChange: Bool? // I added this so that I can reuse the view, with a percent s