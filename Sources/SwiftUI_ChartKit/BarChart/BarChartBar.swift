//
//  BarChartBar.swift
//  SwiftUI_ChartKit
//
//  Created by Fynn Bandemer on 24.06.20.
//

import SwiftUI

struct BarChartBar: View {
    @State var show : Bool = false
    @Binding var value: Double
    @Binding var color: Color
    var gradient: Gradient?
    var width: CGFloat
    var cornerRadius: CGFloat
    var barBackgroundColor: Color?
    var animation: Animation?
    var strokeColor: Color?
    var strokeLineWidth: CGFloat?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(LinearGradient(gradient: gradient ?? Gradient(colors: [color,color]), startPoint: .bottom, endPoint: .top))
                .frame(width: width)
                .scaleEffect(CGSize(width: 1, height: show ? value : 0), anchor: .bottom)
                .animation(.linear)
            if strokeColor != nil {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(strokeColor!, lineWidth: strokeLineWidth ?? 3)
                    .frame(width: width)
                    .scaleEffect(CGSize(width: 1, height: show ? value : 0), anchor: .bottom)
                    .animation(.linear)
            }
        }
        .background(barBackgroundColor ?? Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
        .animation(animation ?? .none)
        .onAppear {
            self.show = true
        }
    }
}
