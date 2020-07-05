//
//  PieChartSlide.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 05.07.20.
//

import SwiftUI

struct PieChartSlide: View {
    @State var show: Bool = false
    @State var highlighted: Bool = false
    @Binding var data: Double
    @Binding var style: ChartStyle
    var animationDelay: Double
    var width: CGFloat
    var index: Int
    var startAngle: Double
    
    var slideData: SlideData {
        return SlideData(index: index, startAngle: startAngle, data: data)
    }
    
    var path: Path {
        let radius = width / 2
        let centerX = radius //+ slideData.deltaX
        let centerY = radius //+ slideData.deltaY
        
        var path = Path()
        path.move(to: CGPoint(x: centerX, y: centerY))
        path.addArc(
            center: CGPoint(x: centerX, y: centerY),
            radius: radius,
            startAngle: slideData.startAngle,
            endAngle: slideData.endAngle,
            clockwise: false)
        return path
    }
    
    
    var body: some View {
        path.fill(style.color)
            .overlay(path.stroke(style.strokeColor ?? .white, lineWidth: style.strokeLineWidth ?? 1))
            .offset(x: highlighted ? slideData.offsetX : 0, y: highlighted ? slideData.offsetY : 0)
            .scaleEffect(show ? 1 : 0)
            .animation(Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.8).delay(Double(animationDelay) * 0.3))
            .onTapGesture {
                self.highlighted.toggle()
            }
            .onAppear {
                self.show = true
            }
    }
}
