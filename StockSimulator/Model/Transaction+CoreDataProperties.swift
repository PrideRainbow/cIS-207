//
//  Transaction+CoreDataProperties.swift
//  StockSimulator
//
//  Created by Christopher Walter on 7/18/22.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var buyDate: Date?
    @NSManaged public var costBasis: Double
    @NSManaged public var id: UUID?
    @NSManaged public var isClosed: Bool
    @NSManaged public var numShares: Double
    @NSManaged public var purchasePrice: Double
    @NSManaged public var sellDate: Date?
    @NSManaged public var sellPrice: Double
    @NSManaged public var totalProceeds: Double
    @NSManaged public var eventType: String? // This will be used to determine, if we have a dividend payment, splits, etc. // might not need because each transaction has a buy and a sell. Also when you apply a dividend, you are applying
    @NSManaged public var account: Account?
    @NSManaged public var stock: Stock?
    @NSManaged public var dividends: NSSet?
    @NSManaged public var splits: NSSet?
    
    //    // Cost basis is when we buy
    //    var costBasis: Double {
    //        return numShares * purchasePrice
    //    }
    //
    //    // total proceeds are when we sell
    //    var totalProceeds: Double {
    //        return numShares * sellPrice
    //    }
    
    // might not need eventtype.
    var wrappedEventType: String {
        return eventType ?? "UnKnown"
    }
    
//    var toString: String {
//        var result = "\(wrappedEventType): \(numShares) of \(stock?.wrappedSymbol ?? "UnKnown") at price $\(purchasePrice) on date \(buyDate?.asShortDateString() ?? Date().asShortDateString())"
//        
//        if let sellDate = sellDate {
//            result += "\nSold on date \(sellDate) at price $\(sellPrice)"
//        }
//        return result
//    }
    
    var wrappedBuyDate: Date {
        return self.buyDate ?? Date()
    }
    
        
    var currentValue: Double {
        if isClosed == false {
            if let theStock = stock {
                return theStock.regularMarketPrice * numShares
            }
        }
        return 0.0
    }
        
    func closeTransaction(sellPrice: Double)
    {
        self.sellDate = Date()
        self.isClosed = true
        self.sellPrice = sellPrice
        self.totalProceeds = self.numShares * sellPrice
        self.eventType = "\(wrappedEventType)/SELL"
    }
    
    func copyTransaction(from transaction: Transaction)
    {
        // do not copy UUID... Each transaction should be unique...
        self.purchasePrice = transaction.purchasePrice
        self.buyDate = transaction.buyDate
        self.numShares = transaction.numShares
        self.isClosed = transaction.isClosed
        self.sellDate = transaction.sellDate
        self.sellP