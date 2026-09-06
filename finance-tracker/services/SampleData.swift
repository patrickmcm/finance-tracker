//
//  SampleData.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 06/09/2026.
//

import Foundation
import SwiftUI

struct SampleData: PreviewModifier {
    static func makeSharedContext() -> NetworkManager {
        return NetworkManager(test: true)
    }
    
    func body(content: Content, context: NetworkManager) -> some View {
        content
            .environment(context)
    }
}
