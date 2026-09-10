//
//  SampleData.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 06/09/2026.
//

import Foundation
import SwiftUI
import SwiftData

struct SampleData: PreviewModifier {
    static func makeSharedContext() -> NetworkManager {
        return NetworkManager(test: true)
    }
    
    func body(content: Content, context: NetworkManager) -> some View {
        content
            .environment(context)
    }
}

@MainActor
class SampleSwiftData {
    static let shared = SampleSwiftData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var marketSymbol = {
        MarketSymbol.sampleData.first
    }
    
    private init() {
        let schema = Schema([
            MarketSymbol.self,
        ])
        
        let modelConfig = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfig])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func generateMockStockData(days: Int = 30, startingPrice: Decimal = 150.0) -> [MarketSymbolPriceData] {
        var dataPoints: [MarketSymbolPriceData] = []
        let calendar = Calendar.current
        var currentPrice: Decimal = startingPrice
        
        for i in 0..<days {
            // Calculate a random percentage change between -2% and +2.2% (slight upward bias)
            let changePercent = Decimal(Double.random(in: -0.022...0.02))
            currentPrice = currentPrice * (1.0 + changePercent)
            
            // Ensure price never drops to zero or below
            currentPrice = max(currentPrice, 1.0)
            
            // Generate past dates leading up to today
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                dataPoints.append(MarketSymbolPriceData(timestamp: date, marketBid: currentPrice, marketAsk: currentPrice))
            }
        }
        
        // Sort chronologically so the chart draws left-to-right
        return dataPoints.sorted(by: { $0.timestamp < $1.timestamp })
    }
    
    private func insertSampleData() {
        for symbol in MarketSymbol.sampleData {
            if symbol.ticker == "VUAG" {
                symbol.priceData = generateMockStockData(days: 1000, startingPrice: 150)
            }
            
            context.insert(symbol)
        }
    }
    
}
