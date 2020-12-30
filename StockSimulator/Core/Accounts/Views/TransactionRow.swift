//
//  TransactionRow.swift
//  StockSimulator
//
//  Created by Christopher Walter on 7/21/22.
//

import SwiftUI

struct TransactionRow: View {
    
    var transaction: Transaction
    var body: some View {
        VStack {
            HStack {
                Text("\(transaction.eventType ?? "Unknown"): ")
                    .font(.headline)
      