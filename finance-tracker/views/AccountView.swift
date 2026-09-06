//
//  AccountView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
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

#Preview(traits: .modifier(SampleData())) {
    AccountView()
}
