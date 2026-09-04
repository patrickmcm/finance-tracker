//
//  CashView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 04/09/2026.
//

import SwiftUI

struct CashView: View {
    var body: some View {
        NavigationStack {
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
                    CashTransactionCard(date: .now, status: TransactionStatus.PENDING, amount: 2500)
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
}

#Preview {
    CashView()
}
