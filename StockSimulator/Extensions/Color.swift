//
//  Color.swift
//  StockSimulator
//
//  Created by Christopher Walter on 4/14/22.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    let buttonColor = Color("ButtonColor")
    let yellow = Color("YellowColor")
    
}

struct ColorTheme2 {
    let accent = Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha