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
    let email: String
    let firstName: String
    let lastName: String
    
    var netWorth: Double
    var cashTransactions: [CashTransaction]
    
}
