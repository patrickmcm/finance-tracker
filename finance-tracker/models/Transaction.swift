//
//  Transaction.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 06/09/2026.
//

import Foundation

enum TransactionStatus: String, CaseIterable, Identifiable {
    case PENDING = "Pending"
    case COMPLETE = "Complete"
    case FAILED = "Failed"
    
    var id: Self {self}
}

enum TransactionType: String, CaseIterable, Identifiable {
    case WITHDRAWAL = "Withdrawal"
    case DEPOSIT = "Deposit"
    
    var id: Self {self}
}

struct CashTransaction: Identifiable {
    let id: String
    let date: Date
    let amount: Double
    let status: TransactionStatus
    let type: TransactionType
}
