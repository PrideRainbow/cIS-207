
//
//  StockSnapshot.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/4/22.
//


import Foundation
import SwiftUI


// This is the data that is actually loaded from the API
// MARK: - QuoteSnapshot
struct QuoteSnapshot: Codable {
    let quoteResponse: QuoteResponse
}

// MARK: - QuoteResponse
struct QuoteResponse: Codable {
    let result: [StockSnapshot]
    let error: JSONNull?
}
struct StockSnapshot: Codable, Identifiable
{
//    enum quoteType: String, Decodable
//    {
//        case EQUITY, CRYPTOCURRENCY, CURRENCY
//    }
    var quoteType: String
    var displayName: String? // Apple
    var shortName, longName: String? 
    var currency: String // USD, etc
    var symbol: String // AAPL
    var language: String // en-US
    var ask: Double? // 170.7
    var bid: Double? // 170.6
    var market: String // us-market
    var regularMarketDayHigh: Double // 170.35
    var regularMarketDayLow: Double // 162.8
    var regularMarketPrice: Double // 170.33
    let regularMarketChange, regularMarketChangePercent: Double
    
    
    var dividendDate: Int? // 1652313600
    var tradeable: Bool // false
    let earningsTimestamp: Int? // 1659038400
    let trailingPE: Double? // 25.055285
    let trailingAnnualDividendRate, trailingAnnualDividendYield, epsTrailingTwelveMonths: Double? // 0.88, 0.005664628, 6.15
    let epsForward, epsCurrentYear, priceEpsCurrentYear: Double? // 6.51, 6.13, 25.13703
    let sharesOutstanding: Int? // 16185199616
    let bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent: Double? // 4.158, 143.2188, 10.871201, 0.07590624
    let twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent: Double // 158.59525, -4.505249, -0.028407214,
    let marketCap: Int? // 2493977460736
    let forwardPE, priceToBook: Double? // 23.669737, 37.05868
    
    let averageAnalystRating: String? // "1.9 - Buy"
    let priceHint: Int // 2
    let postMarketChangePercent: Double? // -0.103838
    let postMarketTime: Int? // 1658534393
    let postMarketPrice, postMarketChange: Double? // 153.93, -0.160004
    let regularMarketTime: Int // 1658520003
    let regularMarketDayRange: String // 153.4101 - 156.28
    let regularMarketVolume: Int // 66675408
    let regularMarketPreviousClose: Double // 155.35
    let bidSize, askSize: Int? // 11, 8
    let fullExchangeName, financialCurrency: String? // NasdaqGS, USD
    let regularMarketOpen: Double // 155.39
    let averageDailyVolume3Month, averageDailyVolume10Day: Int // 93032838, , 72702620
    let fiftyTwoWeekLowChange: Double // 25.050003
    let fiftyTwoWeekRange: String // "129.04 - 182.94"
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh: Double // -28.850006,-0.15770201, 129.04, 182.94
    
    // added for Crypto stuff
    let circulatingSupply: Int?
    let lastMarket: String?
    let volume24Hr, volumeAllCurrencies: Int?
    let fromCurrency, toCurrency: String?
    let coinMarketCapLink: String?
    let startDate: Int?
    let coinImageURL, logoURL: String?
    
    var id = UUID()
    
    
    
    var regularMarketChangeFormatted: String {
        if regularMarketChange < 0 {
            let value = regularMarketChange * -1
            return String(format: "-$%.2f", value)
        }
        else {
            return String(format: "+$%.2f", regularMarketChange)
        }
        
    }
    
    var regularMarketChangePercentFormatted: String {
        if regularMarketChangePercent < 0 {
            let value = regularMarketChangePercent * -1
            return String(format: "-%.2f", value) + "%"
        }
        else {
            return String(format: "+%.2f", regularMarketChangePercent) + "%"
        }
        
    }
    
    var wrappedDisplayName: String {
        if let disp = displayName {
            return disp
        }
        else if let short = shortName {
            return short
        }
        else if let long = longName {
            return long
        }
        else
        {
            return "No Name Found"
        }
    }

//    var id: Int = UUID().hashValue
    // these are added so that I can have the id property that is required for Identifiable. I need identifiable so that I can easily display in a stocks in a list.
    private enum CodingKeys: String, CodingKey {
        case quoteType, displayName, currency, symbol, language, ask, bid, market, regularMarketDayHigh, regularMarketDayLow, regularMarketPrice, shortName, longName, regularMarketChange, regularMarketChangePercent, dividendDate, tradeable, earningsTimestamp,trailingAnnualDividendRate, trailingPE, trailingAnnualDividendYield, epsTrailingTwelveMonths, epsForward, epsCurrentYear, priceEpsCurrentYear, sharesOutstanding, bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent, marketCap, forwardPE, priceToBook, averageAnalystRating, priceHint, postMarketChangePercent, postMarketTime, postMarketPrice, postMarketChange, regularMarketTime, regularMarketDayRange, regularMarketVolume, regularMarketPreviousClose, bidSize, askSize, fullExchangeName, financialCurrency, regularMarketOpen, averageDailyVolume3Month, averageDailyVolume10Day, fiftyTwoWeekLowChange, fiftyTwoWeekRange, fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh, circulatingSupply, lastMarket, volume24Hr, volumeAllCurrencies, fromCurrency, toCurrency, coinMarketCapLink, startDate, coinImageURL, logoURL
    }



    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quoteType = try values.decode(String.self, forKey: .quoteType)

//        // Some stocks like DIS do not have a displayName, they have a longName and shortName instead...
        do {
            displayName = try values.decode(String.self, forKey: .displayName)
        }
        catch {
            displayName = nil
        }
//        displayName = try values.decode(String.self, forKey: .displayName)
        shortName = try? values.decode(String.self, forKey: .shortName)
        longName = try? values.decode(String.self, forKey: .longName)
        currency = try values.decode(String.self, forKey: .currency)
        symbol = try values.decode(String.self, forKey: .symbol)
        language = try values.decode(String.self, forKey: .language)
        ask = try? values.decode(Double.self, forKey: .ask)
        bid = try? values.decode(Double.self, forKey: .bid)
        market = try values.decode(String.self, forKey: .market)
        regularMarketDayHigh = try values.decode(Double.self, forKey: .regularMarketDayHigh)
        regularMarketDayLow = try values.decode(Double.self, forKey: .regularMarketDayLow)
        regularMarketPrice = try values.decode(Double.self, forKey: .regularMarketPrice)
        regularMarketChange = try values.decode(Double.self, forKey: .regularMarketChange)
        regularMarketChangePercent = try values.decode(Double.self, forKey: .regularMarketChangePercent)
        
        dividendDate = try? values.decode(Int.self, forKey: .dividendDate)
        tradeable = try values.decode(Bool.self, forKey: .tradeable)
        earningsTimestamp = try? values.decode(Int.self, forKey: .earningsTimestamp)
        trailingAnnualDividendRate = try? values.decode(Double.self, forKey: .trailingAnnualDividendRate)
        trailingPE = try? values.decode(Double.self, forKey: .trailingPE)
        trailingAnnualDividendYield = try? values.decode(Double.self, forKey: .trailingAnnualDividendYield)
        epsTrailingTwelveMonths = try? values.decode(Double.self, forKey: .epsTrailingTwelveMonths)
        epsForward = try? values.decode(Double.self, forKey: .epsForward)
        epsCurrentYear = try? values.decode(Double.self, forKey: .epsCurrentYear)
        priceEpsCurrentYear = try? values.decode(Double.self, forKey: .priceEpsCurrentYear)
        sharesOutstanding = try? values.decode(Int.self, forKey: .sharesOutstanding)