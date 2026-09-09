//
//  finance_trackerApp.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI
import SwiftData

@main
struct finance_trackerApp: App {
    @State private var networkManager: NetworkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkManager)
                .modelContainer(for: [
                    MarketSymbol.self
                ])
        }
    }
}
