//
//  NetworkManager.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 06/09/2026.
//

import Foundation

@Observable
class NetworkManager {
    var user: User
    
    init(test: Bool = false) {
        if test {
            let transactions: [CashTransaction] = [
                CashTransaction(id: "0", date: .now, amount: 250, status: .PENDING, type: .DEPOSIT),
                CashTransaction(id: "1", date: .init(timeInterval: -60 * 60 * 24, since: .now), amount: 345, status: .COMPLETE, type: .DEPOSIT),
                CashTransaction(id: "2", date: .init(timeInterval: -60 * 60 * 72, since: .now), amount: 234, status: .FAILED, type: .WITHDRAWAL),
            ]
            
            let accounts: [Account] = [
                Account(id: "0", name: "Western Markets", accountType: .SSISA, value: 40000)
            ]
            
            let testUser: User = User(id: "1234", email: "tst@gmail.com", firstName: "Patrick", lastName: "McManamon", portfolioWorth: 56900, cashWorth: 2400, cashTransactions: transactions, accounts: accounts)
            
            self.user = testUser
            return
        }
        
        //placeholder, here would fetch from server
        let realUser: User = User(id: "1234", email: "tst@gmail.com", firstName: "Patrick", lastName: "McManamon", portfolioWorth: 50000, cashWorth: 2400, cashTransactions: [], accounts: [])
        
        self.user = realUser
    }
}
