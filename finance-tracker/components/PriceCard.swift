//
//  PriceCard.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 08/09/2026.
//

import SwiftUI

struct PriceCard: View {
    let price: Decimal?
    let timestamp: Date?
    let percentageChange: Double?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if price != nil && timestamp != nil {
                    Text(price!, format: .number.precision(.fractionLength(2)))
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("\(AppSettings.defaultCurrency) • \(timestamp!.formatted(.dateTime))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                } else {
                    Text("---.--")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("\(AppSettings.defaultCurrency) • --/--/--, --:--")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(5)
            Spacer()
            VStack(alignment: .trailing) {
                PercentagePill(percentage: percentageChange)
            }
            .bold()
        }
    }
}

#Preview {
    PriceCard(price: 123, timestamp: .now, percentageChange: 5)
}

#Preview("nil view") {
    PriceCard(price: 123, timestamp: nil, percentageChange: nil)
}
