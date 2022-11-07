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
    
    // I used quickType.io to decode the data. It was having trouble with the ExchangeTimeZone Enum, so I changed that to String and it works great now. More data than I need.
    func getMarketData() {
        
        let apiCaller = APICaller.shared
        apiCaller.getMarketData { connectionResult in
            switch connectionResult {
            case .marketSummarySuccess(let marketData):
                self.marketData = marketData
            case .failure(let string):
                print("Failure: \(string)")
            default:
                print("Found something that was unexpected 