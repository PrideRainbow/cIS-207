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
            switc