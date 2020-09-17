//
//  ChartModel.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 24.06.20.
//

import SwiftUI

@available(iOS 13.0, *)
public class ChartModel: ObservableObject {
    @Published public var chartData = [ChartDataPoint]()
    @Published public var chartStyle : ChartStyle

    
    public init(values: [Double]) {
        self.chartStyle = ChartStyle()
        let total = values.reduce(0.0, +)
        for dataPoint in values {
            if let maxValue = values.max() {
                if maxValue > 0 {
                    self.chartData.append(ChartDataPoint(yValue: dataPoint, normalizedValue: (dataPoint / maxValue), percantage: dataPoint / total * 100, xValue: ""))
                } else {
                    self.chartData.append(ChartDataPoint(yValue: dataPoint, normalizedValue: 0, percantage: 0, xValue: ""))
                }
                
            } else {
                // TODO: Error Tracking
                self.chartData.append(ChartDataPoint(yValue: dataPoint, normalizedValue: 1, percantage: dataPoint / total * 100, xValue: ""))
            }
        }
    }
    
    public func updateData(values: [Double]) {
        chartData.removeAll()
        let total = values.reduce(0.0, +)
        for dataPoint in values {
            if let maxValue = values.max() {
                if maxValue > 0 {
                    chartData.append(ChartDataPoint(yValue: dataPoint, normalizedValue: (dataPoint / maxValue), percantage: dataPoint / total * 100, xValue: ""))
                } else {
                    chartData.append(ChartDataPoint(yValue: dataPoint, normalizedValue: 0, percantage: 0, xValue: ""))
                }
                
                
            } else {
                // TODO: Error Tracking
                chartData.append(ChartDataPoint(yValue: dataPoint, normalizedValue: 1, percantage: dataPoint / total * 100, xValue: ""))
            }
        }
    }
    
    public func setColor(color: Color) -> ChartModel {
        chartStyle.color = color
        chartStyle.reflectionColor = color.opacity(0.5)
        if chartStyle.gradient != nil {
            chartStyle.gradient = nil
        }
        return self
    }
    
    public func setColors(colors: [Color]) -> ChartModel {
        chartStyle.colors = colors
        chartStyle.reflectionColors = colors.map { $0.opacity(0.5) }
        return self
    }
    
    public func setGradient(colors: [Color]) -> ChartModel {
        chartStyle.gradient = Gradient(colors: colors)
        chartStyle.reflectionGradient = Gradient(colors: colors.map { $0.opacity(0.5) })
        return self
    }
    
    public func setCornerRadius(cornerRadius: CGFloat) -> ChartModel {
        chartStyle.cornerRadius = cornerRadius
        return self
    }
    
    public func setBarBackgroundColor(barBackgroundColor: Color) -> ChartModel {
        chartStyle.barBackgroundColor = barBackgroundColor
        return self
    }
    
    public func setAnimation(animation: Animation) -> ChartModel {
        chartStyle.animation = animation
        return self
    }
    
    public func setAppearDuration(appearDuration: Double) -> ChartModel {
        chartStyle.appearDuration = appearDuration
        return self
    }
    
    public func setTapAnimationDuration(tapAnimationDuration: Double) -> ChartModel {
        chartStyle.tapAnimationDuration = tapAnimationDuration
        return self
    }
    
    public func setWhiteSpaceRatio(whiteSpaceRatio: Double) -> ChartModel {
        chartStyle.whiteSpaceRatio = whiteSpaceRatio
        return self
    }
    
    public func setStrokeColor(strokeColor: Color) -> ChartModel {
        chartStyle.strokeColor = strokeColor
        return self
    }
    
    public func setStrokeLineWidth(strokeLineWidth: CGFloat) -> ChartModel {
        chartStyle.strokeLineWidth = strokeLineWidth
        return self
    }
    
    public func setReflectionRatio(reflectionRatio: Double) -> ChartModel {
        chartStyle.reflectionRatio = reflectionRatio
        return self
    }
    
    public func setInsert(insert: Double) -> ChartModel {
        chartStyle.insert = insert
        return self
    }
    
}
