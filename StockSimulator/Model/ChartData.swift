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
    var exchangeName: 