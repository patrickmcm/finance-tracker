//
//  CashView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 04/09/2026.
//

import SwiftUI

struct CashView: View {
    
    @Environment(NetworkManager.self) private var networkManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var isPresented: Bool = false
    @State private var txType: CashTransactionType = .DEPOSIT
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        Text(networkManager.user.availableCash, format: .currency(code: AppSettings.defaultCurrency))
                        Spacer()
                    }
                    .font(.largeTitle)
                    .bold()
                    HStack {
                        Spacer()
                        Image(systemName: "hourglass")
                        Text(networkManager.user.totalCash - networkManager.user.availableCash, format: .currency(code: AppSettings.defaultCurrency))
                        Spacer()
                    }
                    .font(.title)
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
        .sheet(isPresented: $isPresented) {
            if txType == .DEPOSIT {
                NavigationStack {
                    DepositView()
                }
                
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Deposit") {
                    txType = .DEPOSIT
                    isPresented.toggle()
                }
                Button("Withdraw") {
                    txType = .WITHDRAWAL
                    isPresented.toggle()
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
