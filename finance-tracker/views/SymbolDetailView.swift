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
    
    @State private var action: MarketActionType?
    
    @State private var chartEngine: ChartEngine<MarketSymbolPriceData> = ChartEngine()
    
    var body: some View {
        List {
            Section {
                let sortedPrices = marketSymbol.priceData.sorted { first, second in
                    first.timestamp > second.timestamp
                }
                let latest = sortedPrices.first
                
                let visibleData = chartEngine.visibleData(priceData: marketSymbol.priceData)
                
                let first = visibleData.first
                let last = visibleData.last
                
                let percentageChange: Decimal = (((last?.value ?? 0) - (first?.value ?? 0)) / (last?.value ?? 1))*100
                
            
                PriceCard(price: latest!.marketAsk, timestamp: latest!.timestamp, percentageChange: Double(truncating: percentageChange as NSNumber))
            
                SymbolChart(priceData: marketSymbol.priceData, chartEngine: chartEngine)
        }
    }
        .listStyle(.grouped)
        .navigationTitle(marketSymbol.ticker)
        .navigationSubtitle(marketSymbol.fullName)
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Buy") {
                    action = .BUY
                }
                Button("Sell") {
                    action = .SELL
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
            .controlSize(.extraLarge)
            .buttonSizing(.flexible)
            .buttonStyle(.glass)
        }
        .sheet(item: $action) { action in
            NavigationStack {
                MarketActionView(action: action, symbol: marketSymbol)
            }
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
