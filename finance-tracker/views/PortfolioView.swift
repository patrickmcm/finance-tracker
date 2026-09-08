//
//  PortfolioView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI
import SwiftData

struct PortfolioView: View {
    @State private var accountSheetOpen = false
    
    @Environment(NetworkManager.self) private var networkManager
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Text("graph placeholder")
                        .font(.title)
                    Spacer()
                }
                .frame(height: 153)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
            }
            
            
            Section {
                NavigationLink {
                    CashView()
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Total")
                                .font(.title)
                                .bold()
                            Text("Cash")
                                .font(.title2)
                            
                        }
                        Spacer()
                        VStack(alignment: .trailing,spacing: 10) {
                            Text(networkManager.user.portfolioWorth, format: .currency(code: AppSettings.defaultCurrency))
                                .font(.title)
                                .bold()
                            Text(networkManager.user.cashWorth, format: .currency(code: AppSettings.defaultCurrency))
                                .font(.title2)
                        }
                    }
                    .padding(5)
                }
            }
            
            Section(header: Text("Accounts"), content: {
                ForEach(networkManager.user.accounts) { account in
                    NavigationLink {
                        Text(account.name)
                    } label: {
                        SymbolCard(cardTitle: account.name, cardDescription: "Stocks and Shares ISA", price: account.value, percentageChange: -0.01)
                    }
                }
            })
            .headerProminence(.increased)
        }
        .navigationTitle(Text("Portfolio"))
        .toolbar {
            ToolbarItemGroup {
                NavigationLink {
                    SearchView()
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                
                Button("My Account", systemImage: "person.circle") {
                    accountSheetOpen.toggle()
                }
                .sheet(isPresented: $accountSheetOpen) {
                    AccountView()
                }
            }
        }
    }
    
}

#Preview(traits: .modifier(SampleData())) {
    NavigationStack {
        PortfolioView()
    }
    .modelContainer(SampleSwiftData.shared.modelContainer)

}
