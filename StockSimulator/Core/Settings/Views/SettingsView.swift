
//
//  SettingsView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 8/3/22.
//


import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let defaultURL = URL(string: "https://www.google.com")!

//    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let yahooFinanceURL = URL(string: "https://financeapi.net/")!
    let personalURL = URL(string: "https://www.cwalterbuilds.com")!
    let githubURL = URL(string: "https://github.com/cwalter50/StockSimulator")!
    let personalGithubURL = URL(string: "https://github.com/cwalter50")!
    
    
    var body: some View {
        NavigationView {
            List {
                developerSection
                yahooFinanceSection
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    })
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {