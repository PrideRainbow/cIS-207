//
//  AddWatchlistView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/4/22.
//

import SwiftUI

struct AddWatchlistView: View {
    @State var name: String
    
    @Environment(\.managedObjectContext) var moc // CoreData
//    @EnvironmentObject var vm : StocksViewModel

    // will allow us to dismiss
    @Environment(\.presentationMode) var pre