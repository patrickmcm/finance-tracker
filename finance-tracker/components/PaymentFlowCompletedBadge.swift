//
//  SuccessBadge.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 07/09/2026.
//

import SwiftUI

struct PaymentFlowCompletedBadge: View {
    let success: Bool
    let caption: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: success ? "checkmark.circle" : "xmark.circle")
                .foregroundStyle(success ? .green : .red)
                .font(.system(size: 128))
                .bold()
            Text(caption)
                .font(.largeTitle)
                .bold()
        }
    }
}

#Preview {
    PaymentFlowCompletedBadge(success: true, caption: "Deposit Requested")
}

#Preview("Failed") {
    PaymentFlowCompletedBadge(success: false, caption: "Deposit Failed")
}
