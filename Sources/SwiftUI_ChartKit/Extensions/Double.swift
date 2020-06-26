//
//  Double.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 26.06.20.
//

import SwiftUI

extension Double {
    static func getPointDistance(p1: CGPoint, p2: CGPoint) -> Double {
        return Double((pow((p2.x - p1.x), 2) + pow((p2.y - p1.y), 2)).squareRoot())
    }
}
