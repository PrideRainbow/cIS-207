//
//  Stock+CoreDataProperties.swift
//  StockSimulator
//
//  Created by Christopher Walter on 7/27/22.
//
//

import Foundation
import CoreData


extension Stock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock")
    }

    @NSManaged public var ask: Double
    @NSManaged public var askSize: Int32
    @NSManaged public var averageAnalystRating: String?
    @NSManaged public var averageDailyVolume3Month: Int64
    @NSManaged public var averageDailyVolume10Day: Int64
    @NSManaged public var bid: Double
    @NSManaged public var bidSize: Int32
    @NSManaged public var bookValue: Double
    @NSManaged public var currency: String?
    @NSManaged public var displayName: String?
    @NSManaged public var dividendDate: Int32
    @NSManaged public var earningsTimestamp: Int32
    @NSMana