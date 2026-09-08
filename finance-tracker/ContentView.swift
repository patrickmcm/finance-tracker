//
//  ContentView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            PortfolioView()
        }
    }
}

#Preview(traits: .modifier(SampleData())) {
    ContentView()
        .modelContainer(SampleSwiftData.shared.modelContainer)
}
