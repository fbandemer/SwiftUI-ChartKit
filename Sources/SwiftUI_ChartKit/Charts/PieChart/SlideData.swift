//
//  SlideData.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 05.07.20.
//

import SwiftUI

struct SlideData: Identifiable {
    let id: UUID = UUID()

    var startAngle: Angle! = .degrees(0)
    var endAngle: Angle! = .degrees(0)
    
    var annotation: String! = ""
    var annotationDeltaX: CGFloat! = 0.0
    var annotationDeltaY: CGFloat! = 0.0
    
    var deltaX: CGFloat! = 0.0
    var deltaY: CGFloat! = 0.0
    
    var offsetX: CGFloat! = 0.0
    var offsetY: CGFloat! = 0.0
    
    
    init(index: Int, startAngle: Double, data: Double) {
        self.annotation = String(index)
        self.startAngle = .degrees(startAngle)
        let angle = data * 3.6
        let alpha = startAngle + angle / 2
        self.endAngle = .degrees(startAngle + angle)
        
        let deltaX = CGFloat(cos(abs(alpha).truncatingRemainder(dividingBy: 90.0) * .pi / 180.0))
        let deltaY = CGFloat(sin(abs(alpha).truncatingRemainder(dividingBy: 90.0) * .pi / 180.0))
        
        let annotationDeltaX = deltaX * (0.7)
        let annotationDeltaY = deltaY * (0.7)
        
        if -90 <= alpha && alpha < 0 {
            self.offsetX = deltaX * 20.0
            self.offsetY = -deltaY * 20.0
            self.annotationDeltaX = annotationDeltaX
            self.annotationDeltaY = -annotationDeltaY
        } else if 0 <= alpha && alpha < 90 {
            self.offsetX = deltaX * 20.0
            self.offsetY = deltaY * 20.0
            self.annotationDeltaX = annotationDeltaX
            self.annotationDeltaY = annotationDeltaY
        } else if 90 <= alpha && alpha < 180 {
            self.offsetX = -deltaX * 20.0
            self.offsetY = deltaY * 20.0
            self.annotationDeltaX = -annotationDeltaY
            self.annotationDeltaY = annotationDeltaX
        } else {
            self.offsetX = -deltaX * 20.0
            self.offsetY = -deltaY * 20.0
            self.annotationDeltaX = -annotationDeltaX
            self.annotationDeltaY = -annotationDeltaY
        }
    }
}
