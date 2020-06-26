//
//  CGPoint.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 26.06.20.
//

import SwiftUI

extension CGPoint {
    static func getMiddlePoint(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }
    
    static func getQuadCurveControlPoint(p1: CGPoint, p2: CGPoint, quadScaling: CGFloat? = 1) -> CGPoint {
        var controlPoint = CGPoint.getMiddlePoint(p1: p1, p2: p2)
        let yDiff = abs(p2.y - controlPoint.y)
        if p1.y < p2.y {
            controlPoint.y += yDiff * quadScaling!
        } else {
            controlPoint.y -= yDiff * quadScaling!
        }
        return controlPoint
    }
}
