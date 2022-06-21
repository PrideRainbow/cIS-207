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
    @NSManaged public var epsCurrentYear: Double
    @NSManaged public var epsForward: Double
    @NSManaged public var epsTrailingTwelveMonths: Double
    @NSManaged public var fiftyDayAverage: Double
    @NSManaged public var fiftyDayAverageChange: Double
    @NSManaged public var fiftyDayAverageChangePercent: Double
    @NSManaged public var fiftyTwoWeekHigh: Double
    @NSManaged public var fiftyTwoWeekHighChange: Double
    @NSManaged public var fiftyTwoWeekHighChangePercent: Double
    @NSManaged public var fiftyTwoWeekLow: Double
    @NSManaged public var fiftyTwoWeekLowChange: Double
    @NSManaged public var fiftyTwoWeekRange: String?
    @NSManaged public var financialCurrency: String?
    @NSManaged public var forwardPE: Double
    @NSManaged public var fullExchangeName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var language: String?
    @NSManaged public var longName: String?
    @NSManaged public var market: S