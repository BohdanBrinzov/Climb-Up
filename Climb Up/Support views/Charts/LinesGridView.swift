//
//  LinesGridView.swift
//  Climb Up
//
//  Created by Bohdan on 30.11.2020.
//

import SwiftUI

struct LinesGrid: View {
    
    @Binding var data: [Double]
    @Binding var frame: CGRect
    
    var isDates: Bool
    
    let padding: CGFloat = 3
    
    var stepWidth: CGFloat {
        if data.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.count-1)
    }
    
    var stepHeight: CGFloat {
        let points = self.data
        if let min = points.min(), let max = points.max(), min != max {
            if (min < 0){
                return (frame.size.height-padding) / CGFloat(max - min)
            }else{
                return (frame.size.height-padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    
    var min: CGFloat {
        let points = self.data
        return CGFloat(points.min() ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            if isDates {
                ForEach((0...4), id: \.self) { height in
                    HStack(alignment: .center){
                        Text("\(Double(self.getYDateGridSafe(height: height)).asDateString(style: .abbreviated))").offset(x: 0, y: self.getYposition(height: height) )
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        self.line(atHeight: self.getYGridSafe(height: height), width: self.frame.width)
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [5,height == 0 ? 0 : 10]))
                            .rotationEffect(.degrees(180), anchor: .center)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .animation(.easeOut(duration: 0.2))
                            .clipped()
                    }
                }
            } else {
                ForEach((0...4), id: \.self) { height in
                    HStack(alignment: .center){
                        Text("\(self.getYGridSafe(height: height), specifier: "%.0f") %").offset(x: 0, y: self.getYposition(height: height) )
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        self.line(atHeight: self.getYGridSafe(height: height), width: self.frame.width)
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [5,height == 0 ? 0 : 10]))
                            .rotationEffect(.degrees(180), anchor: .center)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .animation(.easeOut(duration: 0.2))
                            .clipped()
                    }
                }
            }
        }
    }
    
    func getYGridSafe(height: Int) -> CGFloat {
        if let grid = getYGrid() {
            return CGFloat(grid[height])
        }
        return 0
    }
    
    func getYDateGridSafe(height: Int) -> CGFloat {
        if height == 0 {
            return 0
        }
        if let grid = getYDateGrid() {
            return CGFloat(grid[height])
        }
        return 0
    }
    
    func getYposition(height: Int) -> CGFloat {
        if let grid = getYGrid() {
            return (self.frame.height - ((CGFloat(grid[height]) - min) * self.stepHeight)) - (self.frame.height / 2)
        }
        return 0
        
    }
    
    func line(atHeight: CGFloat, width: CGFloat) -> Path {
        var hLine = Path()
        hLine.move(to: CGPoint(x: 5, y: (atHeight - min) * stepHeight))
        hLine.addLine(to: CGPoint(x: width, y: (atHeight - min) * stepHeight))
        return hLine
    }
    
    func getYGrid() -> [Double]? {
        let points = self.data
        guard let max = points.max() else { return nil }
        guard let min = points.min() else { return nil }
        let step = Double(max - min)/4
        return [min + step * 0, min+step * 1, min+step * 2, min+step * 3, min+step * 4]
    }
    
    
    func getYDateGrid() -> [Double]? {
        let points = self.data
        guard let max = points.max() else { return nil }
        let min = 0.0
        let step = Double(max - min)/4
        return [min + step * 0, min+step * 1, min+step * 2, min+step * 3, min+step * 4]
    }
}
