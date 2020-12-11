//
//  AssetView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/16/22.
//

import SwiftUI

struct AssetView: View {
    
    // will allow us to dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var moc // CoreData
    
    var asset: Asset
    var account: Account
    
    var body: some View {
        
        List {
            StockBasicView(stockSnapshot: StockSnapshot(stock: asset.stock))
            ChartView(symbol: asset.stock.wrappedSymbol)
//                ChartView(stockSnapsho