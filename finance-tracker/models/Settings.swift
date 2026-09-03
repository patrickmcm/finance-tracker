//
//  Settings.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import Foundation

enum CurrencyCode: String, CaseIterable, Identifiable {
    case USD
    case GBP

    var id: Self { self }
}
