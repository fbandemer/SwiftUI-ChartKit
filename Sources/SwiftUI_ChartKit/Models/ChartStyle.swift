//
//  ChartStyle.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 24.06.20.
//

import SwiftUI

@available(iOS 13.0, *)
public struct ChartStyle {
    var color: Color = .blue
    var reflectionColor: Color = Color.blue.opacity(0.4)
    var gradient: Gradient?
    var reflectionGradient: Gradient?
    var cornerRadius: CGFloat = 0
    var barBackgroundColor: Color?
    var animation: Animation?
    var appearDuration: Double = 0.8
    var tapAnimationDuration: Double = 0.3
    var whiteSpaceRatio: Double = 0.1
    var strokeColor: Color?
    var strokeLineWidth: CGFloat?
    var reflectionRatio: Double?
    var insert: Double = 22
    var numberOfLines: Int = 2
    var lineWidth: CGFloat = 3
    
//    public init() {    }
}
