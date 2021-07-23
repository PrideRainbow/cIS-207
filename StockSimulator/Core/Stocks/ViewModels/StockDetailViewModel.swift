//
//  StockDetailViewModel.swift
//  StockSimulator
//
//  Created by Christopher Walter on 7/27/22.
//

import Foundation
import SwiftUI
import Combine

class StockDetailViewModel: ObservableObject
{
    @Published var symbol: String = ""
//    @Published var stock: Stock? = nil
    
    @Published va