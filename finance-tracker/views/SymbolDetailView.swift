//
//  SymbolDetailView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 08/09/2026.
//

import SwiftUI
import SwiftData
import Charts

struct SymbolDetailView: View {
    var marketSymbol: MarketSymbol
    
    @State private var isPresented = false
    @State private var txType: MarketActionType = .BUY
    
    var body: some View {
        List {
            Section {
                let sortedPrices = marketSymbol.priceData.sorted { first, second in
                    first.timestamp > second.timestamp
                }
                let latest = sortedPrices.first
                
                PriceCard(price: latest!.marketAsk, timestamp: latest!.timestamp, percentageChange: 5)
            }
            Section {
                Chart(marketSymbol.priceData) {
                    LineMark(x: .value("Date", $0.timestamp), y: .value("Price", $0.marketAsk))
                }
            }
        }
        .navigationTitle(marketSymbol.ticker)
        .navigationSubtitle(marketSymbol.fullName)
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Buy") {
                    txType = .BUY
                    isPresented.toggle()
                }
                Button("Sell") {
                    txType = .SELL
                    isPresented.toggle()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
            .controlSize(.extraLarge)
            .buttonSizing(.flexible)
            .buttonStyle(.glass)
        }
    }
}

#Preview {
    @Previewable @State var marketSymbol = MarketSymbol.sampleData[0]
    
    NavigationStack {
        SymbolDetailView(marketSymbol: marketSymbol)
            .modelContainer(SampleSwiftData.shared.modelContainer)
    }
}
