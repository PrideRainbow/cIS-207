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
                Spacer()
                Text("Cost Basis: \(transaction.costBasis.asCurrencyWith6Decimals())")
                    .font(.headline)
                    .foregroundColor(Color.theme.green)

            }
            HStack {
                Text("\(transaction.wrappedBuyDate.asShortDateString())")
                    .font(.subheadline)
                    .foregro