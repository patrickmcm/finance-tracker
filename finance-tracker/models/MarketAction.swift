//
//  MarketAction.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 09/09/2026.
//

import Foundation

enum MarketActionType: String, CaseIterable, Identifiable {
    case BUY = "Buy"
    case SELL = "Sell"
    
    var id: Self {self}
}

enum MarketActionMethod: String, CaseIterable, Identifiable {
    case MARKET = "Market"
    case LIMIT = "Limit"
    
    var id: Self {self}
}

struct MarketAction {
    let symbol: MarketSymbol
    let type: MarketActionType
    let method: MarketActionMethod
    let status: TransactionStatus
    let date: Date
    let units: Decimal
    let executionPrice: Decimal
}
