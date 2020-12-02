//
//  AccountRow.swift
//  StockSimulator
//
//  Created by Christopher Walter on 2/26/22.
//

import SwiftUI

struct AccountRow: View {
    
    @Environment(\.managedObjectContext) var moc // CoreData
    
    var vm: AccountViewModel
    var account: Account
    
    init(account: Account)
    {
        self.account = account
        vm = AccountViewModel(account: self.account)
    }
    
    var body: some View {
        HStack (alignment: .firstTextBaseline){
            Text(account.wrappedName)
                .font(.title3)
                .fontWeight(.bold)
            Spac