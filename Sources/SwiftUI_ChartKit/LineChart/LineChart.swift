//
//  LineChart.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 26.06.20.
//

import SwiftUI

struct LineChart: View {
    @Binding var data: [ChartDataPoint]
    @Binding var style : ChartStyle
    @State var yVal : CGFloat = 0
    
    
    var body: some View {
        VStack {
            Text("\(yVal)")
            GeometryReader { geometry in
                LineView(dataPoints: self.$data, style: self.$style, frame: .init(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).height), yPos: self.$yVal)
                
            }
        }
        
    }
    
    
}
