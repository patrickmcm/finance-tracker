//
//  InstrumentChart.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 10/09/2026.
//

import SwiftUI
import Charts
import SwiftData

protocol ChartDataPoint: Identifiable {
    var timestamp: Date { get }
    var value: Decimal { get }
}

enum ChartTimeInterval: String, Identifiable, CaseIterable {
    case WEEK = "1W"
    case MONTH = "1M"
    case YTD = "YTD"
    case YEAR = "1Y"
    case TWO_YEAR = "2Y"
    case FIVE_YEAR = "5Y"
    case ALL = "ALL"
    
    var id: Self {self}
}

@Observable class ChartEngine<T: ChartDataPoint> {
    var selectedInterval: ChartTimeInterval
    
    private func chartRange(priceData: [T]) -> ClosedRange<Date> {
        let endDate = priceData.last?.timestamp ?? Date()
        let calendar = Calendar.current
        
        let currentYear = calendar.component(.year, from: endDate)
        
        let startDate: Date
        switch selectedInterval {
        case .WEEK:
            startDate = calendar.date(byAdding: .day, value: -7, to: endDate) ?? endDate
        case .MONTH:
            startDate = calendar.date(byAdding: .month, value: -1, to: endDate) ?? endDate
        case .YTD:
            startDate = calendar.date(from: DateComponents(year: currentYear)) ?? endDate
        case .YEAR:
            startDate = calendar.date(byAdding: .year, value: -1, to: endDate) ?? endDate
        case .TWO_YEAR:
            startDate = calendar.date(byAdding: .year, value: -2, to: endDate) ?? endDate
        case .FIVE_YEAR:
            startDate = calendar.date(byAdding: .year, value: -5, to: endDate) ?? endDate
        case .ALL:
            startDate = priceData.first?.timestamp ?? endDate
        }
        
        return startDate ... endDate
    }
    
    func visibleData(priceData: [T]) -> [T] {
        priceData.filter { chartRange(priceData: priceData).contains($0.timestamp) }
    }
    
    init(selectedInterval: ChartTimeInterval = .WEEK) {
        self.selectedInterval = selectedInterval
    }
}

struct SymbolChart<T: ChartDataPoint>: View {
    let priceData: [T]
    
    @Bindable var chartEngine: ChartEngine<T>
    
    var body: some View {
        Picker("Time Interval", selection: $chartEngine.selectedInterval) {
            ForEach(ChartTimeInterval.allCases) { interval in
                Text(interval.rawValue).tag(interval)
            }
        }
        .pickerStyle(.segmented)
        Chart(chartEngine.visibleData(priceData: priceData)) { point in
            LineMark(x: .value("Date", point.timestamp), y: .value("Price", point.value))
        }
        .frame(width: .infinity, height: 200)
        .chartYScale(domain: .automatic(includesZero: false))
    }
}

#Preview {
    @Previewable @State var chartEngine = ChartEngine<MarketSymbolPriceData>()
    let symbol = MarketSymbol.sampleData[0]

    SymbolChart(priceData: symbol.priceData, chartEngine: chartEngine)
        .modelContainer(SampleSwiftData.shared.modelContainer)
}
