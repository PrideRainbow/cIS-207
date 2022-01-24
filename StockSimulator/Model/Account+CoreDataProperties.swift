//
//  Account+CoreDataProperties.swift
//  StockSimulator
//
//  Created by Christopher Walter on 7/5/22.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var cash: Double
    @NSManaged public var created: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var startingValue: Double
    @NSManaged public var transactions: NSSet?

}

extension Account {
    
    var wrappedName: String {
        name ?? "No Name"
    }
    
    var wrappedNotes: String {
        notes ?? "Add Notes..."
    }
    
    var currentValue: Double {
        var total = cash
        if let theTransactionsSet = self.transactions, let theTransactions = Array(theTransactionsSet) as? [Transaction] {
            for t in theTransactions {
                total += t.currentValue
            }
            
        }
        return total
    }
    
    var percentChange:String {
        if currentValue >= startingValue
        {
            let growth = (currentValue / startingValue - 1) * 100
            return String(format: "+%.1f", growth)