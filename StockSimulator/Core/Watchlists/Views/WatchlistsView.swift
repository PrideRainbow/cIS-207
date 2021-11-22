//
//  WatchlistsView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/4/22.
//

import SwiftUI

struct WatchlistsView: View {
    @Environment(\.managedObjectContext) var moc // CoreData
    
    @Environment(\.editMode) private var editMode
    
//    @EnvironmentObject var vm: StocksViewModel
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Watchlist.created, ascending: false)], animation: Animation.default) var watchlists: FetchedResults<Watchlist>
    
    @State var isAddWatchlistPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(watchlists) {
                    watchlist in
                    NavigationLink(destination: WatchlistView(watchlist: watchlist)) {
                        Text(watchlist.wrappedName)
                    }
                    
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navig