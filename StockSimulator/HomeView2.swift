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
            .foregroundColor(.black)
            VStack(spacing: 10) {
                Text("Total Balance")
                    .fontWeight(.bold)
                Text("$ 51 200")
                    .font(.system(size: 38, weight: .bold))
            }
            .padding(.top, 20)
            Button {
                
            } label: {
                HStack(spacing: 5) {
                    Text("Income")
                    Image(systemName: "chevron.down")
                }
                .font(.caption.bold())
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(.white, in: Capsule())
                .foregroundColor(.black)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.03), radius: 5, x: -5, y: -5)
            }
            // GraphView
            LineGraphView(data: samplePlot)
                .frame(height: 220)
                .padding(.top, 25)
            Text("Shortcuts")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    CardView(image: "CWBuildsLogo", title: "CWBuilds", price: "$ 26", color: Color.theme.green)
                    CardView(image: "logo", title: "Stock SImulator", price: "$ 2600", color: Color.theme.green)
              