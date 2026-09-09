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

struct MarketSymbolPriceData: Codable, Identifiable {
    var timestamp: Date
    var marketBid: Decimal
    var marketAsk: Decimal
    
    var id: Date {timestamp}
}

@Model
class MarketSymbol {
    #Unique<MarketSymbol>([\.isin])
    
    var isin: String
    var fullName: String
    var ticker: String
    var symbolType: MarketSymbolType
    
    @Transient
    var priceData = [MarketSymbolPriceData]()

    init(isin: String, symbolName: String, ticker: String, symbolType: MarketSymbolType, priceData: [MarketSymbolPriceData] = [MarketSymbolPriceData]()) {
        self.isin = isin
        self.fullName = symbolName
        self.ticker = ticker
        self.symbolType = symbolType
        self.priceData = priceData
    }
    
    static let sampleData: [MarketSymbol] = [
        MarketSymbol(isin: "IE00BFMXXD54", symbolName: "VANGUARD S&P 500 UCITS ETF", ticker: "VUAG", symbolType: .ETF, priceData: [
            MarketSymbolPriceData(timestamp: .now, marketBid: 107.5, marketAsk: 107.6),
            MarketSymbolPriceData(timestamp: .init(timeIntervalSinceNow: -60*60*24), marketBid: 105.5, marketAsk: 105.6),
        ]),
        MarketSymbol(isin: "LU1230136894", symbolName: "AMUNDI SMART OVERNIGHT RETURN GBP HEDGED", ticker: "CSH2", symbolType: .ETF, priceData: [
            MarketSymbolPriceData(timestamp: .now, marketBid: 1250.9, marketAsk: 1251),
            MarketSymbolPriceData(timestamp: .init(timeIntervalSinceNow: -60*60*24), marketBid: 1250.7, marketAsk: 1250.8)
        ]),
    ]
}
