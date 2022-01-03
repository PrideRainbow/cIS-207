//
//  Account+CoreDataClass.swift
//  StockSimulator
//
//  Created by Christopher Walter on 7/5/22.
//
//

import Foundation
import CoreData


public class Account: NSManagedObject {
    
    //    @Published var assets: [Asset] = []
    
    func loadAssets() -> [Asset]
    {
        var theAssets = [Asset]()
        if let theTr