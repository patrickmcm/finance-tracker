//
//  DepositView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 07/09/2026.
//

import SwiftUI

struct DepositView: View {
    @State private var amount: Decimal = 0
    
    var body: some View {
        Form {
            TextField("Amount", value: $amount, format: .currency(code: AppSettings.defaultCurrency))
                .keyboardType(.numberPad)
        }
        .navigationTitle("Deposit")
    }
}

#Preview {
    NavigationStack {
        DepositView()
    }
}
