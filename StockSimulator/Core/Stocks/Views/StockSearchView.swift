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
//    @State var stockSnapshots: [StockSnapshot] = []
    
    @State private var isTradePresented = false
    
    // will allow us to dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    init(watchlist: Watchlist)
    {
        self.watchlist = watchlist
//        stockSnapshot = []
    }
    
    init(theAccount: Account)
    {
        account = theAccount
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter Stock Symbol", text: $searchSymbol)
                    .autocapitalization(.allCharacters)
                Button(action: getStockData) {
                    Text("Search")
                    
                }
                
            }
            .padding()
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text("Error"), message: Text("\(errorMessage)"), primaryButton: .default(Text("OK"), action: nil), secondaryButton: .cancel())
            }
                List {
                    ForEach(vm.stockSnapshots)
                    {
                        stockSnapshot in
                        StockBasicView(stockSnapshot: stockSnapshot)
                        if watchlist != nil
                        {
                            Button(action: {
                                
                                saveToWatchlistCoreData(snapshot: stockSnapshot)
                                
                            }) {
                                Text("Add to WatchList")
                                    .foregroundColor(Color.blue)
                            }
                        }
                        if let theAccount = account
                        {
                            Button(action: {
                                isTradePresented.toggle()
                            }) {
                                Text("Trade")
                                    .foregroundColor(Color.blue)
                            }
                            .sheet(isPresented: $isTradePresented){
                                List {
                                TradeFormView(account: theAccount, stockSnapshot: stockSnapshot)
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())

            Spac