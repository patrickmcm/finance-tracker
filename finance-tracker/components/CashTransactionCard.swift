//
//  CashTransactionCard.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 04/09/2026.
//

import SwiftUI

struct CashTransactionCard: View {
    let transaction: CashTransaction
    
    private var statusLogo: String
    
    init(transaction: CashTransaction) {
        self.transaction = transaction
        
        if transaction.status == .COMPLETE {
            self.statusLogo = transaction.type == .DEPOSIT ? "arrow.down.circle" : "arrow.down.circle"
        } else if transaction.status == .PENDING {
            self.statusLogo = transaction.type == .DEPOSIT ? "arrow.down.circle.dotted" : "arrow.up.circle.dotted"
        } else {
            self.statusLogo = transaction.type == .DEPOSIT ? "xmark.circle" : "xmark.circle"
        }
    }
    
    
    var body: some View {
        HStack {
            Image(systemName: statusLogo)
                .font(.system(size: 32))
                .foregroundStyle(.tint)
            VStack(alignment: .leading) {
                Text(transaction.date, format: .dateTime.day().weekday().month().year())
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("\(transaction.status.rawValue)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
            }
            .padding(5)
            Spacer()
            VStack(alignment: .trailing) {
                Text(transaction.amount.formatted(.currency(code: AppSettings.defaultCurrency)))
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .bold()
        }
    }
}

#Preview {
    let trans = CashTransaction(id: "0", date: .now, amount: 237, status: .COMPLETE, type: .DEPOSIT)
    
    CashTransactionCard(transaction: trans)
}
