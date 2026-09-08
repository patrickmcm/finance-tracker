//
//  SymbolCardView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI

struct SymbolCard: View {
    let cardTitle: String
    let cardDescription: String
    let price: Decimal
    let percentageChange: Double?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cardTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(cardDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
            }
            .padding(5)
            Spacer()
            VStack(alignment: .trailing) {
                Text(price.formatted(.currency(code: AppSettings.defaultCurrency)))
                    .font(.body)
                    .fontWeight(.semibold)
                if percentageChange != nil {
                    PercentagePill(percentage: percentageChange!)
                }
            }
            .bold()
        }
    }
}

#Preview {
    SymbolCard(cardTitle: "VUAG", cardDescription: "Vanguard S&P 500", price: 56569, percentageChange: 0.01)
}
