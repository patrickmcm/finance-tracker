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
                CashTransaction(id: "2", date: .init(timeInterval: -60 * 60 * 24 * 3, since: .now), amount: 234, status: .FAILED, type: .WITHDRAWAL),
            ]
                        
            let symbols: [AccountSymbol] = [
                AccountSymbol(id: "0", marketSymbol: MarketSymbol.sampleData[0], units: 1.25),
                AccountSymbol(id: "1", marketSymbol: MarketSymbol.sampleData[1], units: 0.5)
            ]
            
            let actions: [MarketAction] = [
                MarketAction(symbol: MarketSymbol.sampleData[0], type: .BUY, method: .MARKET, status: .COMPLETE,date: .now, units: 1.25, executionPrice: 100),
                MarketAction(symbol: MarketSymbol.sampleData[1], type: .BUY, method: .MARKET, status: .COMPLETE,date: .now, units: 0.5, executionPrice: 1200)
            ]
            
            let totalValue:[UserValue] = [
                UserValue(timestamp: .init(timeIntervalSinceNow: -60*60*24*2), value: 100000),
                UserValue(timestamp: .init(timeIntervalSinceNow: -60*60*24), value: 150000),
                UserValue(timestamp: .now, value: 200000),
            ]
            
            let value: [AccountValue] = [
                AccountValue(timestamp: .init(timeIntervalSinceNow: -60*60*24*2), value: 45000),
                AccountValue(timestamp: .init(timeIntervalSinceNow: -60*60*24), value: 50000),
                AccountValue(timestamp: .now, value: 56900),
            ]
            
            let accounts: [Account] = [
                Account(id: "0", name: "Western Markets", accountType: .SSISA, symbols: symbols, actions: actions, historicalValue: value)
            ]
            
            let testUser: User = User(id: "1234", email: "tst@gmail.com", firstName: "Patrick", lastName: "McManamon", portfolioWorth: 56900, totalCash: 2400, availableCash: 2000, historicalPortfolioWorth: totalValue, cashTransactions: transactions, accounts: accounts)
            
            self.user = testUser
            return
        }
        
        //placeholder, here would fetch from server
        let realUser: User = User(id: "1234", email: "tst@gmail.com", firstName: "Patrick", lastName: "McManamon", portfolioWorth: 50000, totalCash: 2400, availableCash: 2000, historicalPortfolioWorth: [], cashTransactions: [], accounts: [])
        
        self.user = realUser
    }
}
