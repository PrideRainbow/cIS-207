//
//  StockView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 1/29/22.
//

import SwiftUI

struct StockBasicView: View {
    
//    @State var stockSnapshot: StockSnapshot? = nil
    @State var stockSnapshot: StockSnapshot

    var body: some View {
        VStack {
            HStack (alignment: .firstTextBaseline){
                VStack(alignment: .leading){
                    Text(stockSnapshot.symbol)
                        .font(.title)
                   