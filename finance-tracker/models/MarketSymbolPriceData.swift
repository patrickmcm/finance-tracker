//
//  MarketSymbolPriceData.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 28/09/2026.
//

import Foundation
import OSLog
import GRPCCore
import GRPCNIOTransportHTTP2
import GRPCProtobuf
import SwiftProtobuf

struct MarketSymbolPriceData: Codable, Identifiable, ChartDataPoint {
    let timestamp: Date
    
    let open: Decimal
    let close: Decimal
    let high: Decimal
    let low: Decimal
    
    var value: Decimal {close}
    
    var id: Date {timestamp}
}

extension MarketSymbolPriceData {
    fileprivate static let logger = Logger(subsystem: "com.patmcm.finance-tracker", category: "parsing")

    static private func fetchPriceData(marketSymbol: MarketSymbol, dateFrom: Date, dateTo: Date) async throws -> [V1_InstrumentPrice] {
        try await withGRPCClient(transport: .http2NIOPosix(
            target: .ipv4(address: "127.0.0.1", port: 3000),
            transportSecurity: .plaintext
        )) { client in
            let apiClient = V1_InstrumentsPricesService.Client(wrapping: client)
            
            let params = V1_GetInstrumentPricesRequest.with { req in
                req.ticker = marketSymbol.ticker;
                req.dateFrom = .init(date: dateFrom);
                req.dateTo = .init(date: dateTo);
            }
            
            let prices = try await apiClient.get(params)
            return prices.prices
        }
    }
    
    static func getPriceData(marketSymbol: MarketSymbol, dateFrom: Date, dateTo: Date) async -> [MarketSymbolPriceData] {
        var newPrices: [MarketSymbolPriceData] = []
        do {
            let prices = try await fetchPriceData(marketSymbol: marketSymbol, dateFrom: dateFrom, dateTo: dateTo)
            
            for price in prices {
                let open = Decimal.init(sign: .plus, exponent: Int(price.open.exp), significand: Decimal(price.open.unscaled))
                let close = Decimal.init(sign: .plus, exponent: Int(price.close.exp), significand: Decimal(price.close.unscaled))
                let high = Decimal.init(sign: .plus, exponent: Int(price.high.exp), significand: Decimal(price.high.unscaled))
                let low = Decimal.init(sign: .plus, exponent: Int(price.low.exp), significand: Decimal(price.low.unscaled))

                
                newPrices.append(MarketSymbolPriceData(timestamp: price.timestamp.date, open: open, close: close, high: high, low: low))
            }
        } catch let error {
            logger.error("\(error.localizedDescription)")
        }
        logger.info("\(newPrices)")
        return newPrices
    }
    
    
    
}
