//
//  Settings.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import Foundation

struct AppSettings {
    static let defaultCurrency = "GBP"
}

struct User {
    let id: String
    var email: String
    var firstName: String
    var lastName: String
    var portfolioWorth: Decimal
    var totalCash: Decimal
    var availableCash: Decimal
    
    var cashTransactions: [CashTransaction]
    var accounts: [Account]
}
