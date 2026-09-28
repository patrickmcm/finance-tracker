//
//  MarketSymbolCollection.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 18/09/2026.
//

import Foundation
import SwiftData
import OSLog
import GRPCCore
import GRPCNIOTransportHTTP2
import GRPCProtobuf
import SwiftProtobuf

struct MarketSymbolDTO: Decodable {
    let isin: String
    let fullName: String
    let currency: String
    let symbolType: String
    let ticker: String
}

extension MarketSymbol {
    convenience init(from symbol: V1_Instrument) {
        let symbolType: MarketSymbolType = symbol.type == .etf ? MarketSymbolType.ETF : MarketSymbolType.STOCK
        
        self.init(isin: symbol.isin, symbolName: symbol.name, ticker: symbol.ticker,currency: symbol.currency, symbolType: symbolType)
    }
}

extension MarketSymbolDTO {
    fileprivate static let logger = Logger(subsystem: "com.patmcm.finance-tracker", category: "parsing")
    
    static func fetchSymbols() async throws -> [V1_Instrument] {
        try await withGRPCClient(transport: .http2NIOPosix(
            target: .ipv4(address: "127.0.0.1", port: 3000),
            transportSecurity: .plaintext
        )) { client in
            let apiClient = V1_InstrumentsService.Client(wrapping: client)
            let symbols = try await apiClient.list(request: ClientRequest(message: V1_ListInstrumentRequest.init()))
            return symbols.instruments
        }
    }
    
    static func refresh(context: ModelContext) async {
        do {
            logger.log("Getting Symbols")
            let marketSymbolCollection = try await fetchSymbols()
            
            for symbol in marketSymbolCollection {
                let newSymbol = MarketSymbol(from: symbol)
                
                context.insert(newSymbol)
            }
        } catch let error {
            logger.error("\(error.localizedDescription)")
        }
    }
}

enum DownloadError: Error {
    case wrongDataFormat(error: Error)
    case missingData
}
