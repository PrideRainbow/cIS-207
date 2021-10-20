//
//  StockSearchView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 2/12/22.
//

import SwiftUI

struct StockSearchView: View {
    
    @ObservedObject var vm = StocksViewModel()
    
    @Enviro