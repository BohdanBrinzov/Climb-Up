//
//  LineChartView.swift
//  Climb Up
//
//  Created by Bohdan on 18.11.2020.
//

import SwiftUI


struct ChartLineView: View {
    
    @Binding var points: [Double]
    
    var body: some View {
        ZStack{
            GeometryReader{ geometry in
                LineView(data: $points, frame: .constant(geometry.frame(in: .local)), gradientStart: Color.mainAqua, gradientEnd: Color.mainAqua.opacity(0.8), minDataValue: nil, maxDataValue: nil)
                .drawingGroup()
            }
            .frame(width: 290, height: 200)
            .padding(.leading, 30)
        }.background(
            GeometryReader{ geometry in
                LinesGrid(data: $points, frame: .constant(geometry.frame(in: .local)), isDates: false)
            }.frame(width: 340, height: 160)
            .padding(.bottom, -40)
        ).offset(y: -20)
    }
}

public struct LineView: View {
    
    @Binding var data: [Double]
    @Binding var frame: CGRect
    var gradientStart: Color
    var gradientEnd: Color
    
    var minDataValue: Double?
    var maxDataValue: Double?
    let padding: CGFloat = 40
    
    @State private var showFull: Bool = false
    
    var stepWidth: CGFloat {
        if data.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.count-1)
    }
    
    var stepHeight: CGFloat {
        var min: Double?
        var max: Double?
        let points = self.data
        if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        }else {
            return 0
        }
        if let min = min, let max = max, min != max {
            if (min <= 0){
                return (frame.size.height-padding) / CGFloat(max - min)
            }else{
                return (frame.size.height-padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    
    var path: Path {
        let points = self.data
        return Path.quadCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue)
    }
    
    public var body: some View {
        ZStack {
            self.path
                .trim(from: 0, to: self.showFull ? 1:0)
                .stroke(LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .animation(Animation.easeOut(duration: 1.2))
                .onAppear {
                    self.showFull = true
                }
                .onDisappear {
                    self.showFull = false
                }
                .drawingGroup()
        }
    }
}
