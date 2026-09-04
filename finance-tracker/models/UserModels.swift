//
//  Settings.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import Foundation

enum CurrencyCode: String, CaseIterable, Identifiable {
    case USD
    case GBP

    var id: Self { self }
}

enum TransactionStatus: String, CaseIterable, Identifiable {
    case PENDING = "Pending"
    case COMPLETE = "Complete"
    case FAILED = "Failed"
    
    var id: Self {self}
}

struct AppSettings {
    static let defaultCurrency = "GBP"
}
