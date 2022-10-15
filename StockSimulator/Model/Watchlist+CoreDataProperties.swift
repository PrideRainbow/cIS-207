//
//  Watchlist+CoreDataProperties.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/4/22.
//
//

import Foundation
import CoreData


extension Watchlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Watchlist> {
        return NSFetchRequest<Watchlist>(entityName: "Watchlist")
    }
   