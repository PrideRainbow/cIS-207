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
//                ChartView(stockSnapshot: StockSnapshot(stock: asset.stock))
                .frame(height: 300)
          
            yourSharesSection
            .font(.body)
            
            Section(header: Text("Trade Info")) {
                TradeFormView(account: account, stockSnapshot: StockSnapshot(stock: asset.stock))
            }
            
        }
        .navigationTitle(asset.stock.wrappedSymbol)
    }
    

}

struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        let account = dev.sampleAccount
        let stock = dev.sampleStock
        AssetView(asset: Asset(transactions: [], stock: stock), account:account)
    }
}

extension AssetView {
    
    private var yourSharesSection: some View {
        Section(header: Text("Your Shares")) {
            HStack{
                Text("Market Value:")
                Spacer()
                Text(String(format: "$%.2f", asset.totalValue))
                    .f