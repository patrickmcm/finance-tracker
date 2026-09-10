//
//  Account.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 06/09/2026.
//

import Foundation

enum AccountType: String, CaseIterable, Identifiable {
    case SSISA
    case CISA
    case SIPP
    
    var id: Self {self}
}

struct AccountValue: ChartDataPoint, Identifiable {
    let timestamp: Date
    let value: Decimal
    
    var id: Date {timestamp}
}

struct Account: Identifiable {
    let id: String
    var name: String
    let accountType: AccountType
    
    var symbols: [AccountSymbol]
    var actions: [MarketAction]
    var historicalValue: [AccountValue]
    
    func getValue() -> Decimal {
        var totalWorth: Decimal = 0
        for symbol in symbols {
            totalWorth += symbol.units * (symbol.marketSymbol.priceData.first?.marketAsk ?? 0)
        }
        
        return totalWorth
    }
}
