//
//  AccountSymbol.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 09/09/2026.
//

import Foundation

struct AccountSymbol: Identifiable {
    let id: String
    let marketSymbol: MarketSymbol
    let units: Decimal
}
