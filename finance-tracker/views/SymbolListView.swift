//
//  StockListView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 07/09/2026.
//

import SwiftUI
import SwiftData

struct SymbolListView: View {
    @Query private var marketSymbols: [MarketSymbol]
    
    init(searchText: String = "") {
        let predicate = #Predicate<MarketSymbol> { symbol in
            searchText.isEmpty || symbol.ticker.localizedStandardContains(searchText)
        }
        
        _marketSymbols = Query(filter: predicate)
    }
    
    var body: some View {
        List {
            ForEach(marketSymbols) { symbol in
                let sortedPrices = symbol.priceData.sorted { first, second in
                    first.timestamp > second.timestamp
                }
                let latestAsk = sortedPrices.first?.marketAsk ?? 0
                
                SymbolCard(cardTitle: symbol.ticker, cardDescription: symbol.symbolName, price: latestAsk, percentageChange: nil)
            }
        }
    }
}

#Preview {
    @Previewable @State var searchText = ""
    
    SymbolListView(searchText: searchText)
        .modelContainer(SampleSwiftData.shared.modelContainer)
}
