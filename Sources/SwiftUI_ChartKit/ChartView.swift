//
//  ChartView.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 17.06.20.
//

import SwiftUI

@available(iOS 13.0, *)
public struct ChartView: View {
    public enum ChartTypes {
        case barChart
        case lineChart
    }
    
    var chartType: ChartTypes
    
    @Binding var data: [ChartDataPoint]
    @Binding var style: ChartStyle
    
    var selectedIndex = -1
    
    public init(type: ChartTypes, data: Binding<[ChartDataPoint]>, style: Binding<ChartStyle>) {
        self.chartType = type
        self._data = data
        self._style = style
    }
    
    public var body: some View {
        getChart()
    }

    func getChart() -> AnyView {
        switch chartType {
        case .barChart:
            return AnyView(BarChart(data: $data, style: $style, selectedIndex: selectedIndex))
        case .lineChart:
            return AnyView(LineChart(data: $data, style: $style))
        }
    }
}
