//
//  DepositView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 07/09/2026.
//

import SwiftUI

struct DepositView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var amount: Decimal?
    
    var body: some View {
        Form {
            TextField("Amount", value: $amount, format: .currency(code: AppSettings.defaultCurrency))
                .keyboardType(.numberPad)
                .padding(4)
        }
        .navigationTitle("Deposit")
        .safeAreaInset(edge: .bottom) {
            NavigationLink {
                PaymentFlowCompletedBadge(success: true, caption: "Deposit Requested")
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
                Text("Deposit")
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
    }
}

#Preview {
    NavigationStack {
        DepositView()
    }
}
