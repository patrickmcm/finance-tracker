//
//  MarketActionView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 09/09/2026.
//

import SwiftUI

struct MarketActionView: View {
    let action: MarketAction
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var actionMethod: MarketActionMethod = .MARKET
    @State private var amount: Decimal?
    @State private var limit: Decimal?
    
    var body: some View {
        Form {
            Section {
                Picker("Method", selection: $actionMethod) {
                    Text("Market").tag(MarketActionMethod.MARKET)
                    Text("Limit").tag(MarketActionMethod.LIMIT)
                }
                .pickerStyle(.segmented)
                
                PriceCard(price: action.symbol.priceData[0].marketAsk, timestamp: action.symbol.priceData[0].timestamp, percentageChange: 5)
                
                TextField("Amount", value: $amount, format: .currency(code: AppSettings.defaultCurrency))
                    .keyboardType(.numberPad)
                
                if actionMethod == .LIMIT {
                    TextField("Limit Price", value: $limit, format: .currency(code: AppSettings.defaultCurrency))
                        .keyboardType(.numberPad)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            NavigationLink {
                PaymentFlowCompletedBadge(success: true, caption: "Order Requested")
                    .navigationBarBackButtonHidden()
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss", systemImage: "xmark") {
                                dismiss()
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done", systemImage: "checkmark") {
                                dismiss()
                            }
                            .buttonStyle(.glassProminent)
                        }
                    }
                    
            } label: {
                Text("\(action.type.rawValue)")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
            .controlSize(.extraLarge)
            .buttonSizing(.flexible)
            .buttonStyle(.glassProminent)
        }
        .animation(.easeInOut, value: actionMethod)
        .navigationTitle(action.type.rawValue)
    }
}

#Preview {
    let action = NetworkManager(test: true).user.accounts[0].actions[0]
    
    NavigationStack {
        MarketActionView(action: action)
    }
}
