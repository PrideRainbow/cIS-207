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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section{
                HStack {
                    Text("Name:")
                    TextField("Enter Watchlist Name", text: $name)
                        .autocapitalization(.words)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            Button(action: {
//                vm