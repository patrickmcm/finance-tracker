//
//  finance_trackerApp.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI

@main
struct finance_trackerApp: App {
    @State private var networkManager: NetworkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkManager)
        }
    }
}
