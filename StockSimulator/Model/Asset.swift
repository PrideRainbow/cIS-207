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
                return false
            }
        }
        return true
    }
    
    var averagePurchasePrice: Double {
        
        var sum = 0.0
        for transaction in transactions {
            if transaction.isClosed == false
            {
                sum += transaction.costBasis
            }
        }
        return sum / totalShares
    }
    
    var totalValue: Double {
        return totalShares * stock.regularMarketPrice
    }
    
    var costBasis: Double {
        return averagePurchasePrice * totalShares
    }
    
    var 