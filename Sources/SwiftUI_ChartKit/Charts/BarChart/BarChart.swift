//
//  BarChart.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 24.06.20.
//

import SwiftUI

@available(iOS 13.0, *)
struct BarChart: View {
    @Binding var data: [ChartDataPoint]
    @Binding var style : ChartStyle

    @State var selectedIndex : Int = -1

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: self.getSpacing(width: geometry.frame(in: .local).width)) {
                ForEach(0..<self.data.count, id: \.self) { index in
                    VStack(spacing: 1) {
                        BarChartBar(
                            value: self.$data[index].normalizedValue,
                            color: self.$style.color,
                            gradient: self.style.gradient,
                            width: self.getBarWidth(width: geometry.frame(in: .local).width),
                            cornerRadius: self.style.cornerRadius,
                            barBackgroundColor: self.style.barBackgroundColor,
                            animation: self.style.animation?.delay(self.getAnimationDelay(index: index)),
                            strokeColor: self.style.strokeColor,
                            strokeLineWidth: self.style.strokeLineWidth)
                            .frame(height: geometry.frame(in: .local).height * CGFloat(1 - (self.style.reflectionRatio ?? 0)))
                            .scaleEffect(self.selectedIndex == index ? 1.1 : 1, anchor: .bottom)
                        BarChartBar(
                            value: self.$data[index].normalizedValue,
                            color: self.$style.reflectionColor,
                            gradient: self.style.reflectionGradient,
                            width: self.getBarWidth(width: geometry.frame(in: .local).width),
                            cornerRadius: self.style.cornerRadius,
                            barBackgroundColor: nil,
                            animation: self.style.animation?.delay(self.getAnimationDelay(index: index)),
                            strokeColor: self.style.strokeColor,
                            strokeLineWidth: self.style.strokeLineWidth)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            .scaleEffect(self.selectedIndex == index ? 1.1 : 1, anchor: .top)
                    }
                }
            }
            .animation(.linear(duration: self.style.tapAnimationDuration))
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    self.selectedIndex = self.getSelectedIndex(xAxisLocation: value.location.x, width: geometry.frame(in: .local).width)
                })
                .onEnded({ value in
                    self.selectedIndex = -1
                })
            )
        }
    }
}

extension BarChart {
    
    func getAnimationDelay(index: Int) -> Double {
        return Double(index) / Double(data.count) * style.appearDuration
    }
    
    func getBarWidth(width: CGFloat) -> CGFloat {
        let effectivWidth: Double = getEffectivWidth(width: width)
        let barRatio: Double = (1 - style.whiteSpaceRatio)
        return CGFloat(effectivWidth * barRatio / Double(data.count))
    }
    
    func getSpacing(width: CGFloat) -> CGFloat {
        let effectivWidth: Double = getEffectivWidth(width: width)
        return CGFloat(effectivWidth * style.whiteSpaceRatio / Double(data.count))
    }
    
    func getSelectedIndex(xAxisLocation: CGFloat, width: CGFloat) -> Int {
        let effectivWidth: Double = getEffectivWidth(width: width)
        let borderValue = effectivWidth / Double(data.count)
        return Int(Double(xAxisLocation) / borderValue)
    }
    
    func getEffectivWidth(width: CGFloat) -> Double {
        return Double(width) //- insert
    }
}
