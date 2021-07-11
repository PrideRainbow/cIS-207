//
//  LaunchView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 8/16/22.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Loading your portfolio...".map { String($0) }
    
    @State private var showLoadingText: Bool = false
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @State private var counter: I