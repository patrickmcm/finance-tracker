//
//  InstrumentChart.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 10/09/2026.
//

import SwiftUI
import Charts

struct InstrumentChart: View {
    let symbol: MarketSymbol
    
    var body: some View {
        Chart {
            
        }
    }
}

#Preview {
    let symbol = NetworkManager(test: true).user.accounts[0].symbols[0].marketSymbol
    
    InstrumentChart(symbol: symbol)
}
