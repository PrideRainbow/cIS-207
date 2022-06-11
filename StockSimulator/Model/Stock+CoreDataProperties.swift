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
    @NSManaged public var average