//
//  StockSearchView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 2/12/22.
//

import SwiftUI

struct StockSearchView: View {
    
    @ObservedObject var vm = StocksViewModel()
    
    @Environment(\.managedObjectContext) var moc // CoreData
    
    var watchlist: Watchlist?
    var account: Account?
    
    @State var searchSymbol: String = ""
//    @State var foundStock: Bool = false
//