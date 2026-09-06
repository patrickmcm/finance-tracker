//
//  CashDetailView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 06/09/2026.
//

import SwiftUI

struct CashDetailView: View {
    let transaction: CashTransaction
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        Text(transaction.amount.formatted(.currency(code: AppSettings.defaultCurrency)))
                        Spacer()
                    }
                    
                    .font(.largeTitle)
                    .bold()
                    HStack {
                        Spacer()
                        Text(transaction.date, format: .dateTime.day().weekday(.wide).month(.wide).year())
                        Spacer()
                    }
                    .font(.title2)
                    .foregroundStyle(.secondary)
                }
            }
            .listRowBackground(Color.clear)
            
            Section {
                Text("Status: \(transaction.status.rawValue)\nType: \(transaction.type.rawValue)")
                    .bold()
                Text("VISA 1234")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    let trans = CashTransaction(id: "0", date: .now, amount: 237, status: .COMPLETE, type: .DEPOSIT)
    
    CashDetailView(transaction: trans)
}
