//
//  Asset.swift
//  StockSimulator
//
//  Created by Christopher Walter on 2/26/22.
//

import Foundation


class Asset: Identifiable, ObservableObject
{
    @Published var transactions: [Transaction]
    @Published var id: UUID
    @Publi