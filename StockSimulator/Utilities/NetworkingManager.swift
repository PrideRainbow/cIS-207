//
//  NetworkingManager.swift
//  StockSimulator
//
//  Created by Christopher Walter on 4/27/22.
//

import Foundation
import Combine


class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from the URL: \(url)"
            case .unknown:
                return "[⚠️] unknown error occurred"
            }
        }
    }
    
    static func download(urlRequest: URLRequest, url: URL) -> AnyPublisher<Data, Error> {
        
        
        return URLSession.shared.dataTaskPublis