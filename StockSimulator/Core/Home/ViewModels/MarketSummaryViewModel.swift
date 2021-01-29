//
//  MarketSummaryViewModel.swift
//  StockSimulator
//
//  Created by Christopher Walter on 9/9/22.
//

import Foundation
import SwiftUI

class MarketSummaryViewModel: ObservableObject
{
    @Published var marketData: [MarketSummary] = []
    
    @Published var snpMarketStats: [StatisticModel] = [] // this will display S&P market highlights on homeview
    @Published var dowMarketStats: [StatisticModel] = [] // this will display dow market highlights on homeview
    @Published var nasdaqMarketStats: [StatisticModel] = [] // this will display nasdaq market highlights on homeview
    
    
    @Published var isLoading: Bool = false
    
    init() {
        loadMarketData()
    }
    
    func updateMarketData()
    {
        isLoading = true
        loadMarketData()
        updateOverviewData()
        
    }
    
    func loadMarketData()
    {
        APICaller.shared.getMarketData { result in
            switch result {
            case .marketSummarySuccess(let marketsummary):
                DispatchQueue.main.async {
                    self.marketData = marketsummary
                    self.isLoading = false
                }
                
            case .failure(let string):
                print("Error loading market summary: \(string)")
            default:
                print("error in loading marketsummary")
            }
        }
    }
    
    
    func updateOverviewData() {
        APICaller.shared.getQuoteData(searchSymbols: "^GSPC,^DJI,^IXIC") { result in
            switch result {
            case .success(let stockSnapShots):
                if let snpData = stockSnapShots.first(where: { $0.symbol == "^GSPC" }) {
                    DispatchQueue.main.async {
                        self.snpMarketStats = self.createStatisticModels(stockSnapshot: snpData)
                    }
                }
                if let dowData = stockSnapShots.first(where: { $0.symbol == "^DJI" }) {
                    DispatchQueue.main.async {
                        self.dowMarketStats = self.createStatisticModels(stockSnapshot: dowData)
                    }
                }
                if let nasdaqData = stockSnapShots.first(where: { $0.symbol == "^IXIC" }) {
                    DispatchQueue.main.async {
                        self.nasdaqMarketStats = self.createStatisticModels(stockSnapshot: nasdaqData)
                    }
                }
            case .failure(let string):
                print("Error getting overview stats: " + string)
                
            default:
                print("Error in getting overview data")
            }
        }
    }
    
    func updateDowData() {
        APICaller.shared.getQuoteData(searchSymbols: "^DJI") { result in
            switch result {
            case .success(let stockSnapShots):
                if let snpData = stockSnapShots.first(where: { $0.symbol == "^DJI" }) {
                    DispatchQueue.main.async {
                        self.snpMarketStats = self.createStatisticModels(stockSnapshot: snpData)
                    }
                }
            case .failure(let string):
                print("Error getting S&P stats: " + string)
                
            default:
                print("Error in getting S&P data")
            }
        }
    }
    
    func createStatisticModels(