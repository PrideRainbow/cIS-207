//
//  Array.swift
//  StockSimulator
//
//  Created by Christopher Walter on 5/18/22.
//

import Foundation
import SwiftUI

// This is used to normalize the data in an array so that we can plot it on the graph. Data is all over the place and change the values to all be between 0 and 1. 0 in min, 1 is max. might have to change this to 0.1 and 0.9 in the future, so that we have some white space at the top and bottom of the chart
extension Array where Element == Double {
    // Return the elements of the sequence Normalized
    var normalized: [Double] {
     