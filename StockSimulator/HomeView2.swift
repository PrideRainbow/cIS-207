//
//  HomeView2.swift
//  StockSimulator
//
//  Created by Christopher Walter on 8/9/22.
//

import SwiftUI

struct HomeView2: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .font(.title2)
                }
                Spacer()
                Button {
                    
                } label: {
                    Image("walter")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:45, height: 45)
                        .clipShape(Circle())
                }
            }
            .padding()
          