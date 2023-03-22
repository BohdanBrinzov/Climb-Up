//
//  SupportChartExtentions.swift
//  Climb Up
//
//  Created by Bohdan on 30.11.2020.
//

import SwiftUI

extension Path {

    static func quadCurvedPathWithPoints(points:[Double], step:CGPoint, globalOffset: Double? = nil) -> Path {
        var path = Path()
        if (points.count < 2){
            return path
        }
        let offset = globalOffset ?? points.min()!
        var p1 = CGPoint(x: 0, y: CGFloat(points[0] - offset) * step.y)
        path.move(to: p1)
        for pointIndex in 1..<points.count {
            let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y * CGFloat(points[pointIndex] - offset))
            let midPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p1))
            path.addQuadCurve(to: p2, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p2))
            p1 = p2
        }
        return path
    }
    
}

extension CGPoint {
    
    static func midPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2,y: (p1.y + p2.y) / 2)
    }
    
    static func controlPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
        var controlPoint = CGPoint.midPointForPoints(p1:p1, p2:p2)
        let diffY = abs(p2.y - controlPoint.y)
        
        if (p1.y < p2.y){
            controlPoint.y += diffY
        } else if (p1.y > p2.y) {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
}
