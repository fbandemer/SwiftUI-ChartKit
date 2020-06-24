//
//  ChartView.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 17.06.20.
//

import SwiftUI

import SwiftUI

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
        VStack {
            BarChart(data: $data, style: $style, selectedIndex: selectedIndex)
        }
    }
}
