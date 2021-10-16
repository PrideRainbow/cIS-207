//
//  StockRow.swift
//  StockSimulator
//
//  Created by Christopher Walter on 2/12/22.
//

import SwiftUI

struct StockRow: View {
    
    var stock: Stock
    
    var body: some View {
        HStack (alignment: .firstTextBaseline){
            VStack(alignment: .leading){
                Text(stock.symbol ?? "Unknown")
