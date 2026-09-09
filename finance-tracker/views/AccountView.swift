//
//  AccountView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 09/09/2026.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    let account: Account
    
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
                HStack {
                    Text("Total")
                        .font(.title)
                        .bold()
                    Spacer()
                    Text(account.getValue(), format: .currency(code: AppSettings.defaultCurrency))
                        .font(.title)
                }
                .padding(5)
            }
            
            Section("Instruments") {
                ForEach(account.symbols) { symbol in
                    NavigationLink {
                        SymbolDetailView(marketSymbol: symbol.marketSymbol)
                    } label: {
                        SymbolCard(cardTitle: symbol.marketSymbol.ticker, cardDescription: symbol.marketSymbol.fullName, price: symbol.units * symbol.marketSymbol.priceData[0].marketAsk, percentageChange: nil)
                    }

                }
            }
            
        }
        .navigationTitle(account.name)
    }
}

#Preview(traits: .modifier(SampleData())) {
    let networkManager = NetworkManager(test: true)
    
    NavigationStack {
        AccountView(account: networkManager.user.accounts[0])
    }
    .modelContainer(SampleSwiftData.shared.modelContainer)

}
