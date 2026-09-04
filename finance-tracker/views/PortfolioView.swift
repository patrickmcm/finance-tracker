//
//  PortfolioView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI

struct PortfolioView: View {
    @State private var accountSheetOpen = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        Text("graph placeholder")
                            .font(.title)
                        Spacer()
                    }
                    .frame(height: 153)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                }
                
                
                Section {
                    NavigationLink {
                        CashView()
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Total")
                                    .font(.title)
                                    .bold()
                                Text("Cash")
                                    .font(.title2)
                                
                            }
                            Spacer()
                            VStack(alignment: .trailing,spacing: 10) {
                                Text("£56,569")
                                    .font(.title)
                                    .bold()
                                Text("£2,344")
                                    .font(.title2)
                            }
                        }
                        .padding(5)
                    }
                }
                                
                Section(header: Text("Accounts"), content: {
                    NavigationLink {
                        Text("Western Markets")
                    } label: {
                        SymbolCardView(cardTitle: "Western Markets", cardDescription: "Stocks and Shares ISA", price: 30000, dailyPercentageIncrease: -0.01)
                    }
                    
                    NavigationLink {
                        Text("Eastern Markets")
                    } label: {
                        SymbolCardView(cardTitle: "Eastern Markets", cardDescription: "Stocks and Shares ISA", price: 15000, dailyPercentageIncrease: 0.05)
                    }
                    
                    
                    NavigationLink {
                        Text("Cash Fund")
                    } label: {
                        SymbolCardView(cardTitle: "Cash Fund", cardDescription: "Cash ISA", price: 2000, dailyPercentageIncrease: 0.005)
                    }
                    
                    NavigationLink {
                        Text("Pension")
                    } label: {
                        SymbolCardView(cardTitle: "Pension", cardDescription: "SIPP", price: 14569, dailyPercentageIncrease: 0.5)
                    }
                })
                .headerProminence(.increased)
            }
            .navigationTitle(Text("Portfolio"))
            .toolbar {
                ToolbarItemGroup {
                    Button("Search", systemImage: "magnifyingglass") {
                        // search logic
                    }
                    
                    Button("My Account", systemImage: "person.circle") {
                        accountSheetOpen.toggle()
                    }
                    .sheet(isPresented: $accountSheetOpen) {
                        AccountView()
                    }
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
}
