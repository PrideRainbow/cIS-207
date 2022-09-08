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
        self.sellPrice = transaction.sellPrice
        self.stock = transaction.stock
        self.account = transaction.account
        self.eventType = transaction.eventType
        self.splits = transaction.splits
        self.dividends = transaction.dividends
        self.costBasis = transaction.costBasis
        self.totalProceeds = transaction.totalProceeds
    }
    
    func updateValuesFromBuy(account: Account, purchasePrice:Double, numShares: Double, buyDate: Date)
    {
        self.account = account
        self.id = UUID()
        self.buyDate = buyDate
        self.purchasePrice = purchasePrice
        self.numShares = numShares
        self.isClosed = false
        self.costBasis = purchasePrice * numShares
        self.eventType = "BUY"
//        self.totalProceeds = 0 // this should happen by default
    }

}

// MARK: Generated accessors for dividends
extension Transaction {

    @objc(addDividendsObject:)
    @NSManaged public func addToDividends(_ value: Dividend)

    @objc(removeDividendsObject:)
    @NSManaged public func removeFromDividends(_ value: Dividend)

    @objc(addDividends:)
    @NSManaged public func addToDividends(_ values: NSSet)

    @objc(removeDividends:)
    @NSManaged public func removeFromDividends(_ values: NSSet)

}

// MARK: Generated accessors for splits
extension Transaction {

    @objc(addSplitsObject:)
    @NSManaged public func addToSplits(_ value: Split)

    @objc(removeSplitsObject:)
    @NSManaged public func removeFromSplits(_ value: Split)

    @objc(addSplits:)
    @NSManaged public func addToSplits(_ values: NSSet)

    @objc(removeSplits:)
    @NSManaged public func removeFromSplits(_ values: NSSet)

}

extension Transaction : Identifiable {

}

// MARK: Dividends and Splits methods
extension Transaction {
    // MARK: This will check if Dividend from ChartData is valid before adding it to the transaction's list of dividends and applying it. Be careful of making sure that the Dividend time frame is after the buy date and != to. This could cause recursion, because if you pay a dividend on a date and you check for = to then you will apply the dividend over and over again to the dividend's transaction.
    func addAndApplyDividendIfValid(dividend: ChartData.Dividend, dateOfRecord: String, stockPriceAtDividend: Double?, context: NSManagedObjectContext)
    {
        if isDividendValid(dividend: dividend, dateOfRecord: dateOfRecord) {
            print("Found a valid dividend for \(self.stock?.symbol ?? "No Name"): ")
            print(dividend)
            print("Date of Record: \(dateOfRecord)")
            // make a new Dividend Object
            let d = Dividend(context: context)
            let price = stockPriceAtDividend ?? (stock?.regularMarketPrice ?? purchasePrice)
            d.updateDividendValuesFromChartDataDividend(dividend: dividend, dateOfRecord: dateOfRecord, stockPriceAtDate: price)
            self.addToDividends(d)
            
            // this will create a newTransaction
            self.applyDividend(dividend: d, chartDividend: dividend, context: context)
        }
        else {
//            print("Dividend \(dividend) is not valid to add to transaction." )
        }
    }
    
    // MARK: This will apply a dividend to the transaction and make a new transaction of the dividend
    private func applyDividend(dividend: Dividend, chartDividend: ChartData.Dividend, context: NSManagedObjectContext)
    {
        if dividend.appliedToHolding == false{
            dividend.appliedToHolding = true
            
            // make a new transaction and purchase the number of shares you can buy for the dividend...
            let newCash = dividend.amount * self.numShares
            let newShares = newCash / divide