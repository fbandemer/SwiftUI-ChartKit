//
//  Path.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 26.06.20.
//

import SwiftUI

extension Path {
    static func straightLineChart(dataPoints: [Double], stepLength: CGPoint) -> Path{
        var path = Path()
        guard let offset = dataPoints.min() else { return path }
        let p1 = CGPoint(x: 0, y: CGFloat(dataPoints[0] - offset) * stepLength.y)
        path.move(to: p1)
        for index in 1..<dataPoints.count {
            let p2 = CGPoint(x: CGFloat(index) * stepLength.x, y: CGFloat(dataPoints[index] - offset) * stepLength.y)
            path.addLine(to: p2)
        }
        return path
    }
    
    static func curvedLine(dataPoints: [Double], stepLength: CGPoint, quadScaling: CGFloat? = 1) -> Path {
        var path = Path()
        guard let offset = dataPoints.min() else { return path }
        var p1 = CGPoint(x: 0, y: CGFloat(dataPoints[0] - offset) * stepLength.y)
        path.move(to: p1)
        for index in 1..<dataPoints.count {
            let p2 = CGPoint(x: CGFloat(index) * stepLength.x, y: CGFloat(dataPoints[index] - offset) * stepLength.y)
            
            let middlePoint = CGPoint.getMiddlePoint(p1: p1, p2: p2)
            path.addQuadCurve(to: middlePoint, control: CGPoint.getQuadCurveControlPoint(p1: middlePoint, p2: p1, quadScaling: quadScaling!))
            path.addQuadCurve(to: p2, control: CGPoint.getQuadCurveControlPoint(p1: middlePoint, p2: p2, quadScaling: quadScaling!))
            p1 = p2
        }
        return path
    }
}
