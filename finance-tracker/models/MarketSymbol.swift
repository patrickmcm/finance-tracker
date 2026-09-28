//
//  MarketSymbol.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 07/09/2026.
//

import Foundation
import SwiftData

enum MarketSymbolType: String, CaseIterable, Identifiable, Codable {
    case STOCK
    case ETF
    
    var id: Self {self}
}

struct MarketSymbolPriceData: Codable, Identifiable, ChartDataPoint {
    var timestamp: Date
    var marketBid: Decimal
    var marketAsk: Decimal
    
    var value: Decimal {marketAsk}
    
    var id: Date {timestamp}
}

@Model
class MarketSymbol {
    #Unique<MarketSymbol>([\.isin])
    
    var isin: String
    var fullName: String
    var ticker: String
    var currency: String
    var symbolType: MarketSymbolType
    
    var priceData = [MarketSymbolPriceData]()

    init(isin: String, symbolName: String, ticker: String, currency: String, symbolType: MarketSymbolType, priceData: [MarketSymbolPriceData] = [MarketSymbolPriceData]()) {
        self.isin = isin
        self.fullName = symbolName
        self.ticker = ticker
        self.currency = currency
        self.symbolType = symbolType
        self.priceData = priceData
    }
    
    static let sampleData: [MarketSymbol] = [
        MarketSymbol(isin: "IE00BFMXXD54", symbolName: "VANGUARD S&P 500 UCITS ETF", ticker: "VUAG", currency: "GBX", symbolType: .ETF, priceData: [
            MarketSymbolPriceData(timestamp: .now, marketBid: 107.5, marketAsk: 107.6),
            MarketSymbolPriceData(timestamp: .init(timeIntervalSinceNow: -60*60*24), marketBid: 105.5, marketAsk: 105.6),
            MarketSymbolPriceData(timestamp: .init(timeIntervalSinceNow: -60*60*24), marketBid: 105.5, marketAsk: 105.6),
        ]),
        MarketSymbol(isin: "LU1230136894", symbolName: "AMUNDI SMART OVERNIGHT RETURN GBP HEDGED", ticker: "CSH2", currency: "GBX", symbolType: .ETF, priceData: [
            MarketSymbolPriceData(timestamp: .now, marketBid: 1250.9, marketAsk: 1251),
            MarketSymbolPriceData(timestamp: .init(timeIntervalSinceNow: -60*60*24), marketBid: 1250.7, marketAsk: 1250.8)
        ]),
    ]
}


