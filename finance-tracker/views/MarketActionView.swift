//
//  MarketActionView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 09/09/2026.
//

import SwiftUI

struct MarketActionView: View {
    let action: MarketActionType
    let symbol: MarketSymbol
    
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
                
                PriceCard(price: symbol.priceData[0].marketAsk, timestamp: symbol.priceData[0].timestamp, percentageChange: 5)
                
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
                Text("\(action.rawValue)")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
            .controlSize(.extraLarge)
            .buttonSizing(.flexible)
            .buttonStyle(.glassProminent)
        }
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
                .disabled(true)
            }
        }
        .animation(.easeInOut, value: actionMethod)
        .navigationTitle(action.rawValue)
    }
}

#Preview {
    let action = NetworkManager(test: true).user.accounts[0].actions[0]
    
    NavigationStack {
        MarketActionView(action: .BUY, symbol: action.symbol)
    }
}
