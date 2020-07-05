//
//  LineView.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 26.06.20.
//

import SwiftUI

struct LineView: View {
    @Binding var dataPoints: [ChartDataPoint]
    @Binding var style : ChartStyle
    var frame: CGSize
    
    @State var showIndicator : Bool = false
    @State var show : Bool = false
    @State var touchPosition: CGFloat = 0
    @Binding var yPos: CGFloat
    
    var yValues: [Double] {
        return dataPoints.map { $0.yValue }
    }
    var heightStep : CGFloat {
        if let min = yValues.min(), let max = yValues.max(), min != max {
            return frame.height / CGFloat(max - min)
        } else {
            return 0
        }
    }
    
    var widthStep : CGFloat {
        if dataPoints.count < 2 {
            return 1
        }
        return frame.width / CGFloat(dataPoints.count - 1)
    }
    
    var path: Path {
        if dataPoints.count < 2 {
            return Path()
        }
        return Path.curvedLine(dataPoints: self.yValues, stepLength: CGPoint(x: widthStep, y: heightStep))
    }
    
    var relSegmentPosition : CGFloat {
        return modf(self.touchPosition / self.widthStep).1
    }
    var currentSegment : Int {
        return Int(self.touchPosition / self.widthStep)
    }
    
    var body: some View {
        ZStack {
            
            self.path
                .trim(from: 0, to: self.show ? 1 : 0)
                .stroke(LinearGradient(gradient: style.gradient ?? Gradient(colors: [style.color,style.color]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/) ,style: StrokeStyle(lineWidth: style.lineWidth, lineJoin: .round))
                
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .animation(Animation.easeOut(duration: 1))
                .onAppear {
                    self.show = true
                }
            
            Circle()
                .frame(width: 20, height: 20)
                .position(.init(x: touchPosition, y: yPos))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .opacity(showIndicator ? 1 : 0.001)
            
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({ value in
                if value.location.x < self.frame.width && value.location.x > 0 {
                    self.touchPosition = value.location.x
                }
                self.yPos = self.getY()
                self.showIndicator = true
            })
            .onEnded({ value in
                self.touchPosition = -1
                self.showIndicator = false
            }))
        
    }
    
    func getY() -> CGFloat {
        guard let offset = yValues.min() else { return 1 }
        let p1 = CGPoint(x: CGFloat(currentSegment) * widthStep, y: CGFloat(yValues[currentSegment] - offset) * heightStep)
        let p2 = CGPoint(x: CGFloat(currentSegment + 1) * widthStep, y: CGFloat(yValues[currentSegment + 1] - offset) * heightStep)
        let midPoint = CGPoint.getMiddlePoint(p1: p1, p2: p2)
        
        if relSegmentPosition <= 0.5 {
            let controlPoint = CGPoint.getQuadCurveControlPoint(p1: midPoint, p2: p1)
            return CGFloat.getYForQuad(p1: p1, p2: midPoint, controlPoint: controlPoint, relPos: relSegmentPosition)
        } else {
            let controlPoint = CGPoint.getQuadCurveControlPoint(p1: midPoint, p2: p2)
            return CGFloat.getYForQuad(p1: midPoint, p2: p2, controlPoint: controlPoint, relPos: relSegmentPosition - 0.5)
        }
    }
    
    
}
