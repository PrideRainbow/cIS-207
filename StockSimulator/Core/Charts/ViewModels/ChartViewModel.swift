
//
//  ChartViewModel.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/28/22.
//

import Foundation
import SwiftUI

enum ChartDataResult {
    case success(ChartData)
    case failure(String)
}

final class ChartViewModel: ObservableObject {
//    @Published var chartData: ChartData
    @Published var chartData: ChartData = ChartData(emptyData: true) // this contains close, adjclose, volume, high, low, etc
    @Published var closeData: [Double] = []
    @Published var closeDataNormalized: [Double] = []
    
    @Published var maxY: Double = 0.0
    @Published var minY: Double = 0.0
    @Published var medY: Double = 0.0
    @Published var q1: Double = 0.0
    @Published var q3: Double = 0.0
    @Published var lineColor: Color = Color.theme.green
    @Published var startingDate: Date = Date()
    @Published var endingDate: Date = Date()

    func loadData(symbol: String, range: String, completion: @escaping(ChartDataResult) -> Void ) {
        
        let apiCaller = APICaller.shared
        apiCaller.getChartData(searchSymbol: symbol, range: range) {
            connectionResult in

            switch connectionResult {
                case .chartSuccess(let theChartData):
                    print("loaded data for \(symbol) in the range \(range)")
    //                print(theChartData)
                    DispatchQueue.main.async {
                        self.setData(from: theChartData)
                    }
                    completion(.success(theChartData))
                case .failure(let errorMessage):
                    print("failure loading chart data")
                    DispatchQueue.main.async {
                        self.chartData = ChartData(emptyData: true)
                        self.closeData = []
                        self.closeDataNormalized = []
                        completion(.failure(errorMessage))
                    }
                default: