//
//  AccountView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI

struct AccountView: View {
    @State private var currencyCode: CurrencyCode = CurrencyCode.GBP
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(header: Text("Appearance")) {
                    Picker("Currency", selection: $currencyCode) {
                        Text("GBP").tag(CurrencyCode.GBP)
                        Text("USD").tag(CurrencyCode.USD)
                    }
                }
                
                Section(header: Text("Account")) {
                    Button("Logout") {}
                        .foregroundStyle(.red)
                }
            }
            .navigationTitle(Text("My Account"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Exit", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AccountView()
}
