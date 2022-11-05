//
//  StockDataService.swift
//  StockSimulator
//
//  Created by Christopher Walter on 4/24/22.
//

import Foundation
import Combine
import CoreData
import SwiftUI

class StockDataService: ObservableObject {
    
    @Published var stockSnapshots: [StockSnapshot] = []
    
//    @Published var chartData: ChartData = ChartData(emptyData: true)
    
    @Published var marketData: [MarketSummary] = []
    

    @Environment(\.managedObjectContext) var moc
    
    var stockSubscription: AnyCancellable?
    init() {
//        getQuoteData(searchSymbols: "")
    }
    
    // I used quickType.i