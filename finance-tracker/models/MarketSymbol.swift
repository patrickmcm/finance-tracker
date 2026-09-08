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

@Model
class MarketSymbolPriceData {
    var marketSymbol: MarketSymbol
    var timestamp: Date
    var marketBid: Decimal
    var marketAsk: Decimal
    
    init(marketSymbol: MarketSymbol, timestamp: Date, marketBid: Decimal, marketAsk: Decimal) {
        self.marketSymbol = marketSymbol
        self.timestamp = timestamp
        self.marketBid = marketBid
        self.marketAsk = marketAsk
    }
    
    static let sampleData: [MarketSymbolPriceData] = [
        MarketSymbolPriceData(marketSymbol: MarketSymbol.sampleData[0], timestamp: .now, marketBid: 109.7, marketAsk: 109.74),
        MarketSymbolPriceData(marketSymbol: MarketSymbol.sampleData[0], timestamp: .init(timeIntervalSinceNow: -60 * 60 * 24), marketBid: 109.6, marketAsk: 109.7),
        MarketSymbolPriceData(marketSymbol: MarketSymbol.sampleData[1], timestamp: .now, marketBid: 1250.8, marketAsk: 1250.9),
        MarketSymbolPriceData(marketSymbol: MarketSymbol.sampleData[1], timestamp: .init(timeIntervalSinceNow: -60 * 60 * 24), marketBid: 1250.4, marketAsk: 1250.5)
    ]
}

@Model
class MarketSymbol {
    #Unique<MarketSymbol>([\.isin])
    
    var isin: String
    var symbolName: String
    var ticker: String
    var symbolType: MarketSymbolType
    
    @Relationship(deleteRule: .cascade, inverse: \MarketSymbolPriceData.marketSymbol)
    var priceData = [MarketSymbolPriceData]()

    init(isin: String, symbolName: String, ticker: String, symbolType: MarketSymbolType) {
        self.isin = isin
        self.symbolName = symbolName
        self.ticker = ticker
        self.symbolType = symbolType
    }
    
    static let sampleData: [MarketSymbol] = [
        MarketSymbol(isin: "IE00BFMXXD54", symbolName: "VANGUARD S&P 500 UCITS ETF", ticker: "VUAG", symbolType: .ETF),
        MarketSymbol(isin: "LU1230136894", symbolName: "AMUNDI SMART OVERNIGHT RETURN GBP HEDGED", ticker: "CSH2", symbolType: .ETF),
    ]
}
