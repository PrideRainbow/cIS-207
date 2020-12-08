
//
//  AccountView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 2/26/22.
//

import SwiftUI

struct AccountView: View {
    // CoreData
    @Environment(\.managedObjectContext) var moc
    
    var account: Account
    
    @ObservedObject var vm: AccountViewModel
//    @StateObject var vm: AccountViewModel
    
//    @FetchRequest var transactions: FetchedResults<Transaction>

    @State var isSearchPresented = false
    @State var showingDeleteAlert = false
    
    // this should display an error on the api caller
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    @State var showingDepositView = false
    
    @State var showDetailView = false
    @State var selectedAsset: Asset? = nil
    
    @State var accountName = ""
    @State var notes = ""

    init (account: Account)
    {
        self.account = account

        vm = AccountViewModel(account: account)
        accountName = account.wrappedName
//        _vm = StateObject(wrappedValue: AccountViewModel(account: account))
        

    }
    
    var body: some View {
        VStack(alignment: .center){
            
            NavigationLink(destination: TransactionsView(account: account)) {
                Text("See Transactions")
            }
//            Button {
//                testSampleSplit()
//            } label: {
//                Text("Test Sample Split")
//            }
//
//            Button {
//                testSampleDividend()
//            } label: {
//                Text("Test Sample Dividend")
//            }

            nameAndNotesView
            accountBalanceAndCashView
            

            Divider()
            holdingBarView
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text("Error"), message: Text("\(errorMessage)"), dismissButton: .default(Text("OK")))
            }
            holdingListView
        }
        .background {
            if let sa = selectedAsset {
                NavigationLink(destination: AssetView(asset: sa, account: account), isActive: $showDetailView) {
                    EmptyView()
                }
            } else {
                EmptyView()
            }
            
                
            
        }
        .padding(10)
//        .navigationViewStyle(StackNavigationViewStyle())
        .navigationTitle("Account Overview")
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .onAppear(perform: loadCurrentStockInfo)
//            .navigationBarHidden(true)
        
        
    }
    
    
    func testSampleSplit()
    {
        vm.testSampleSplit(context: moc)
    }
    
    func testSampleDividend()
    {
        vm.testSampleDividend(context: moc)

    }
    func loadCurrentStockInfo()
    {
        vm.updateAssetValues()
        vm.updateSplitsAndDividends(context: moc)
        accountName = vm.account.wrappedName
        notes = vm.account.wrappedNotes
    }
    
    func deleteAccount()
    {
        print("deleteAccount called")
        moc.delete(account)
        try? moc.save()
    }
    
    func updateAccountName() {
        self.account.name = accountName
        if moc.hasChanges {
            try? moc.save()
        }
        print("Updating Name \(accountName)")
    }