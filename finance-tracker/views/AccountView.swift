//
//  AccountView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI

struct AccountView: View {
    @State private var currencyCode: CurrencyCode = CurrencyCode.GBP
    
    var body: some View {
        NavigationStack {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 70))
                .padding(.top, 50)
            Text("Patrick McManamon")
                .font(.largeTitle)
            Form {
                
                Section(header: Text("Appearance")) {
                    Picker("Currency", selection: $currencyCode) {
                        Text("GBP").tag(CurrencyCode.GBP)
                        Text("USD").tag(CurrencyCode.USD)
                    }
                }
                
                Section(header: Text("Account")) {
                    Button("Logout") {}
                }
            }
        }
        
    }
}

#Preview {
    AccountView()
}
