//
//  CashTransactionCard.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 04/09/2026.
//

import SwiftUI

struct CashTransactionCard: View {
    let date: Date
    let status: TransactionStatus
    let amount: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(date, format: .dateTime.day().weekday(.wide).month().year())
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("\(status.rawValue)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
            }
            .padding(5)
            Spacer()
            VStack(alignment: .trailing) {
                Text(amount.formatted(.currency(code: AppSettings.defaultCurrency)))
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .bold()
        }
    }
}

#Preview {
    CashTransactionCard(date: Date.now, status: TransactionStatus.COMPLETE, amount: 237 )
}
