//
//  AccountView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 09/09/2026.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    @State private var chartEngine: ChartEngine<AccountValue> = ChartEngine()
    
    let account: Account
    
    var body: some View {
        List {
            Section {
                SymbolChart(priceData: account.historicalValue, chartEngine: chartEngine)
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
