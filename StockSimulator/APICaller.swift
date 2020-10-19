
////
////  APICaller.swift
////  StockSimulator
////
////  Created by Christopher Walter on 1/29/22.
////

import Foundation

enum ConnectionResult {
    case success([StockSnapshot])
    case chartSuccess(ChartData)
    case marketSummarySuccess([MarketSummary])
    case stockReccomendations([Recommendation])
    case quoteSummarySuccess([QuoteSummary])
    case failure(String)
}

final class APICaller{
    static let shared = APICaller()

    private struct Constants{
//        static let apiKey = "JvcnVegPVxaamusnImc1S1pTgWQoSWnB1zwAIrnP" // started working on 3/5/22. Stopped working on 3/12/22
        static let apiKey = "u0oXimhO5g6AIR9DIy85D80DPTAtPQP95l9FiAkk" // started working on 3/12/22
        static let quoteurlString = "https://yfapi.net/v6/finance/quote?region=US&lang=en&symbols="

        // https://yfapi.net/v6/finance/recommendationsbysymbol/PYPL
        static let reccomdationsBySymbolURL = "https://yfapi.net/v6/finance/recommendationsbysymbol/"
        static let marketSummaryURL = "https://yfapi.net/v6/finance/quote/marketSummary?lang=en&region=US"
        
        static func quoteSummaryURL(symbol: String) -> String {
        // https://yfapi.net/v11/finance/quoteSummary/ura?lang=en&region=US&modules=defaultKeyStatistics%2CassetProfile
            return "https://yfapi.net/v11/finance/quoteSummary/\(symbol)?lang=en&region=US&modules=defaultKeyStatistics%2CassetProfile%2Cearnings"
        }
        
        static func chartURL(symbol: String, range: String, interval: String) -> String {
//            'https://yfapi.net/v8/finance/chart/AAPL?range=1d&region=US&interval=5m&lang=en&events=div%2Csplit'
            return "https://yfapi.net/v8/finance/chart/\(symbol)?range=\(range)&region=US&interval=\(interval)&lang=en&events=div%2Csplit"
        }
    }

    private init() {}
    
    // MARK: this will get stock snapshots for all or multiple stocks... format needs to be SYMBOLA,SYMBOLB,SYMBOLC,... Max of 10 symbols
    public func getQuoteData(searchSymbols: String, completion: @escaping (ConnectionResult) -> Void){
        
        var symbols = ""
        // have to convert symbol into a new form. the when the symbol is ^DJI -> %5EDJI. I do not know why, but I need to convert it to make it work with the API. also CL=F -> CL%3DF
        if searchSymbols.contains("^") {
            let result = searchSymbols.replacingOccurrences(of: "^", with: "%5E")
            symbols = result
        }
        else if searchSymbols.contains("=") {
            let result = searchSymbols.replacingOccurrences(of: "=", with: "%3D")
            symbols = result
        }
        else {
            symbols = searchSymbols
        }
        
        
        let urlString = Constants.quoteurlString + symbols.uppercased()
//        let urlString = Constants.quoteurlString + "AAPL"
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["x-api-key": Constants.apiKey]
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in

            guard let data = data else { return }
            do {
                guard let results =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    print("error in getting JSON")
                    return
                }
                if let message = results["message"] as? String
                {
                    print(message)
                    completion(.failure(message))
                }
                do {
                    let json = try JSONSerialization.data(withJSONObject: results)
//                    print(json)
                    let decoder = JSONDecoder()
                    let quoteSnapshot = try decoder.decode(QuoteSnapshot.self, from: json)
//                    print(quoteSnapshot)
//                    self.stockSnapshots = quoteSnapshot.quoteResponse.result
//                    print("Found these stocks: \(self.stockSnapshots)")
                    completion(.success(quoteSnapshot.quoteResponse.result))
                }
                catch {
                    print(error)
                    completion(.failure(error.localizedDescription))
                }
            }
            catch {
                print(error)
                completion(.failure(error.localizedDescription))
            }
        }
        task.resume()
        
    }
    
    func getChartData(searchSymbol: String, range: String, completion: @escaping (ConnectionResult) -> Void)
    {
        var interval = "1d"
        
        switch range {
        case "1d":
            interval = "5m"
        case "5d":
            interval = "15m"
        case "1y", "max":
            interval = "1wk"
        default:
            interval = "1d"
        }

        
//    https://yfapi.net/v8/finance/chart/AAPL?range=5d&region=US&interval=15m&lang=en&events=div%2Csplit
        let urlString = Constants.chartURL(symbol: searchSymbol.uppercased(), range: range, interval: interval)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["x-api-key": Constants.apiKey]
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }

            do {
                guard let results =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    print("error in getting JSON")
                    return