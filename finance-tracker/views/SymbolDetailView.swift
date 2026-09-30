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
    
    @State private var prices: [MarketSymbolPriceData] = []
    
    @State private var chartEngine: ChartEngine<MarketSymbolPriceData> = ChartEngine()
    
    var body: some View {
        List {
            Section {
                let first = prices.first
                let last = prices.last

                let percentageChange: Decimal = (((last?.close ?? 0) - (first?.close ?? 0)) / (last?.close ?? 1))*100
                
            
                PriceCard(price: last?.close ?? 0, timestamp: last?.timestamp ?? .now, percentageChange: Double(truncating: percentageChange as NSNumber))
            
                SymbolChart(priceData: prices, chartEngine: chartEngine)
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
        .task {
            self.prices = await MarketSymbolPriceData.getPriceData(marketSymbol: self.marketSymbol, dateFrom: .distantPast, dateTo: .now)
        }
}
}

#Preview {
    @Previewable @State var marketSymbol = MarketSymbol(isin: "IE000J7QYHD8", symbolName: "ABRDN ARAW UCITS ETF - GBX", ticker: "ARAW", currency: "GBX", symbolType: .ETF)
    
    NavigationStack {
        SymbolDetailView(marketSymbol: marketSymbol)
            .modelContainer(SampleSwiftData.shared.modelContainer)
    }
}
