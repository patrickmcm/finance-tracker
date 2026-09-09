//
//  NetworkManager.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 06/09/2026.
//

import Foundation
import SwiftData

@Observable
class NetworkManager {
    private(set) var user: User
        
    init(test: Bool = false) {
        if test {
            let transactions: [CashTransaction] = [
                CashTransaction(id: "0", date: .now, amount: 250, status: .PENDING, type: .DEPOSIT),
                CashTransaction(id: "1", date: .init(timeInterval: -60 * 60 * 24, since: .now), amount: 345, status: .COMPLETE, type: .DEPOSIT),
                CashTransaction(id: "2", date: .init(timeInterval: -60 * 60 * 72, since: .now), amount: 234, status: .FAILED, type: .WITHDRAWAL),
            ]
                        
            let symbols: [AccountSymbol] = [
                AccountSymbol(id: "0", marketSymbol: MarketSymbol.sampleData[0], units: 1.25),
                AccountSymbol(id: "1", marketSymbol: MarketSymbol.sampleData[1], units: 0.5)
            ]
            
            let actions: [MarketAction] = [
                MarketAction(symbol: MarketSymbol.sampleData[0], type: .BUY, method: .MARKET, status: .COMPLETE,date: .now, units: 1.25, executionPrice: 100),
                MarketAction(symbol: MarketSymbol.sampleData[1], type: .BUY, method: .MARKET, status: .COMPLETE,date: .now, units: 0.5, executionPrice: 1200)
            ]
            
            let accounts: [Account] = [
                Account(id: "0", name: "Western Markets", accountType: .SSISA, symbols: symbols, actions: actions)
            ]
            
            let testUser: User = User(id: "1234", email: "tst@gmail.com", firstName: "Patrick", lastName: "McManamon", portfolioWorth: 56900, totalCash: 2400, availableCash: 2000, cashTransactions: transactions, accounts: accounts)
            
            self.user = testUser
            return
        }
        
        //placeholder, here would fetch from server
        let realUser: User = User(id: "1234", email: "tst@gmail.com", firstName: "Patrick", lastName: "McManamon", portfolioWorth: 50000, totalCash: 2400, availableCash: 2000, cashTransactions: [], accounts: [])
        
        self.user = realUser
    }
}
