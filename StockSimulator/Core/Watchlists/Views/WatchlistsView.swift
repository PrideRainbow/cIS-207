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
    
//    @EnvironmentObject var vm: StocksViewM