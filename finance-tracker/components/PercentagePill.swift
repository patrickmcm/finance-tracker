//
//  PercentagePillView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI

struct PercentagePill: View {
    let percentage: Float
    
    var body: some View {
        VStack {
            Text("\(percentage, specifier: "%.2f")%")
                .padding(5)
                .bold()
        }
        .frame(minWidth:80)
        .foregroundStyle(.white)
        .background(percentage > 0 ? .green : .red, in: RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    PercentagePill(percentage: 0.05)
}
