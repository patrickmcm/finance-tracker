//
//  StockData.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 03/09/2026.
//

import Foundation

struct StockData: Identifiable {
    var time: Date
    var amount: Double
    var id = UUID()
}
