//
//  CGFloat.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 26.06.20.
//

import SwiftUI

extension CGFloat {
    static func getGradient(p1: CGPoint, p2: CGPoint) -> CGFloat {
        return ((p2.y - p1.y) / (p2.x - p2.x))
    }
    
    static func getYForQuad(p1: CGPoint, p2: CGPoint, controlPoint: CGPoint, relPos: CGFloat) -> CGFloat {
        let t1 : CGFloat = p1.y * pow((CGFloat(1) - relPos * 2), 2)
        let t2 = 2 * controlPoint.y * (CGFloat(1) - relPos * 2) * relPos * 2
        let t3 = p2.y * pow(relPos * 2,2)
        return t1 + t2 + t3
    }
}
