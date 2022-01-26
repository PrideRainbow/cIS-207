//
//  Asset.swift
//  StockSimulator
//
//  Created by Christopher Walter on 2/26/22.
//

import Foundation


class Asset: Identifiable, ObservableObject
{
    @Published var transactions: [Transaction]
    @Published var id: UUID
    @Published var stock: Stock
    
    var totalShares: Double {
        
        var total = 0.0
        for transaction in transactions {
            if transaction.isClosed == false
            {
                total += transaction.numShares
            }
        }
        return total
    }
    
    var isClosed: Bool {
        for t in transactions {
            if t.isClosed == false {
