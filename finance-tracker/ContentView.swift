//
//  ContentView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Environment(NetworkManager.self) private var networkManager
    
    var body: some View {
        NavigationStack {
            PortfolioView()
                .task {
                    await networkManager.update(context: context)
                }
        }
    }
}

#Preview(traits: .modifier(SampleData())) {
    ContentView()
        .modelContainer(SampleSwiftData.shared.modelContainer)
}
