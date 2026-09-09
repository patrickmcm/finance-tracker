//
//  SampleData.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 06/09/2026.
//

import Foundation
import SwiftUI
import SwiftData

struct SampleData: PreviewModifier {
    static func makeSharedContext() -> NetworkManager {
        return NetworkManager(test: true)
    }
    
    func body(content: Content, context: NetworkManager) -> some View {
        content
            .environment(context)
    }
}

@MainActor
class SampleSwiftData {
    static let shared = SampleSwiftData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var marketSymbol = {
        MarketSymbol.sampleData.first
    }
    
    private init() {
        let schema = Schema([
            MarketSymbol.self,
        ])
        
        let modelConfig = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfig])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        for symbol in MarketSymbol.sampleData {
            context.insert(symbol)
        }
    }
    
}
