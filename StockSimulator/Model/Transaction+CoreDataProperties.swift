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

    @NSManaged public var buyDate: Da