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

struct Account: Identifiable {
    let id: String
    let name: String
    let accountType: AccountType
    
    var value: Decimal
}
