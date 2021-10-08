
//
//  StockDetailView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/25/22.
//

import SwiftUI

struct StockDetailView: View {
    
    @Environment(\.managedObjectContext) var moc // CoreData
    
//    @ObservedObject var stock: Stock
    
//    private let additionalInfo: [StatisticModel]
    
    @State private var showFullDescription: Bool = false
    
    @StateObject var vm: StockDetailViewModel
//    @ObservedObject var vm: StockDetailViewModel
    
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]