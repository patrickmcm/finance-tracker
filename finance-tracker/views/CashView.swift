//
//  CashView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 04/09/2026.
//

import SwiftUI

struct CashView: View {
    
    @Environment(NetworkManager.self) private var networkManager
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        Text("£2,344")
                        Spacer()
                    }
                    .font(.system(size: 64))
                    .bold()
                    HStack {
                        Spacer()
                        Image(systemName: "hourglass")
                        Text("£144")
                        Spacer()
                    }
                    .font(.system(size: 32))
                    .foregroundStyle(.secondary)
                }
            }
            .listRowBackground(Color.clear)
            
            Section("Latest Transactions") {
                ForEach(networkManager.user.cashTransactions) { transaction in
                    NavigationLink {
                        CashDetailView(transaction: transaction)
                    } label: {
                        CashTransactionCard(transaction: transaction)
                    }
                }
            }
            .headerProminence(.increased)
        }
        .navigationTitle("Cash")
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Deposit") {
                    
                }
                Button("Withdraw") {
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
            .controlSize(.extraLarge)
            .buttonSizing(.flexible)
            .buttonStyle(.glass)
        }
    }
}

#Preview(traits: .modifier(SampleData())) {
    NavigationStack {
        CashView()
    }
}
