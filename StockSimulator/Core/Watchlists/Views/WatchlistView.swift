
//
//  WatchlistView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/4/22.
//



import SwiftUI

struct WatchlistView: View {
    
    var watchlist: Watchlist
    
    @State private var isSearchPresented = false
    
    @Environment(\.editMode) private var editMode
    
    @Environment(\.managedObjectContext) var moc // CoreData
    
//    @EnvironmentObject var vm : StocksViewModel
    
    
    @FetchRequest var stocks: FetchedResults<Stock> // stocks need load in init, because FetchRequest requires a predicate with the variable watchlist
    
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    init (watchlist: Watchlist)
    {
        self.watchlist = watchlist
        
        self._stocks = FetchRequest(entity: Stock.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Stock.symbol, ascending: true)], predicate: NSPredicate(format: "(ANY watchlists == %@)", self.watchlist), animation: Animation.default)

    }

    var body: some View {
        VStack {
            List {
                ForEach(stocks) { stock in
                    NavigationLink(
                        destination: StockDetailView(stock: stock)) {
                        StockRow(stock: stock)
                        }.isDetailLink(false)

                }
                .onDelete(perform: delete)
                
            }
            .listStyle(PlainListStyle())

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        loadCurrentStockInfo()
                        HapticManager.notification(type: .success)
                    }) {
//                        Text("Reload")
                        Image(systemName: "arrow.clockwise")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isSearchPresented.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                    .sheet(isPresented: $isSearchPresented, onDismiss: loadCurrentStockInfo) {
                        StockSearchView(watchlist: watchlist)
                    }
                }
                ToolbarItem {
                    EditButton()
                }
                
            }
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text("Error"), message: Text("\(errorMessage)"), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("\(watchlist.name ?? "Watchlist")")
            .navigationViewStyle(.stack)
            