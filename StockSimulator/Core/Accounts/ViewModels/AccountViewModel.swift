
//
//  AccountViewModel.swift
//  StockSimulator
//
//  Created by Christopher Walter on 6/9/22.
//

import Foundation
import SwiftUI
import CoreData
import Combine

enum TradeStatus {
    case buySuccess(title: String, message: String)
    case sellSuccess(title: String, message: String)
    case sellAllSuccess(title: String, message: String)
    case error(title: String, message: String)
}

final class AccountViewModel: ObservableObject {
    