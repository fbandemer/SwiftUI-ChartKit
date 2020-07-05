//
//  PieChart.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 05.07.20.
//

import SwiftUI

struct PieChart: View {

    @Binding var data: [ChartDataPoint]
    @Binding var style: ChartStyle
//    var chartData: PieChartData {
//        return PieChartData(data: dataPoints.map { $0.percantage })
//    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<self.data.count, id: \.self) { index in
                PieChartSlide(
                    data: self.$data[index].percantage,
                    style: self.$style,
                    animationDelay: self.getAnimationDelay(index: index),
                    width: geometry.frame(in: .local).width,
                    index: index,
                    startAngle: self.getStartAngle(index: index))
            }
        }
    }
}

extension PieChart {
    func getStartAngle(index: Int) -> Double {
        var angle: Double = -90
        for i in 0..<index {
            angle += data[i].percantage * 3.6
        }
        return angle
    }
    
    func getAnimationDelay(index: Int) -> Double {
        return Double(index) / Double(data.count) * style.appearDuration
    }
}
