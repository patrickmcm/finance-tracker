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
class MarketSymbol {
    #Unique<MarketSymbol>([\.isin])
    
    var isin: String
    var fullName: String
    var ticker: String
    var currency: String
    var symbolType: MarketSymbolType
    
    init(isin: String, symbolName: String, ticker: String, currency: String, symbolType: MarketSymbolType, priceData: [MarketSymbolPriceData] = [MarketSymbolPriceData]()) {
        self.isin = isin
        self.fullName = symbolName
        self.ticker = ticker
        self.currency = currency
        self.symbolType = symbolType
    }
    
    static let sampleData: [MarketSymbol] = [
        MarketSymbol(isin: "IE00BFMXXD54", symbolName: "VANGUARD S&P 500 UCITS ETF", ticker: "VUAG", currency: "GBX", symbolType: .ETF, priceData: [
        ]),
        MarketSymbol(isin: "LU1230136894", symbolName: "AMUNDI SMART OVERNIGHT RETURN GBP HEDGED", ticker: "CSH2", currency: "GBX", symbolType: .ETF, priceData: [
        ]),
    ]
}


