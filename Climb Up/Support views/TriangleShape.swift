//
//  TriangleShape.swift
//  Climb Up
//
//  Created by Bohdan on 13.11.2020.
//

import Foundation
import SwiftUI


struct Triangle: Shape {
    
    private var width: CGFloat
    private var height: CGFloat
    private var radius: CGFloat
    
    init(width: CGFloat,height: CGFloat, radius: CGFloat ) {
        self.width = width
        self.height = height
        self.radius = radius
    }
    
    func path(in rect: CGRect) -> Path {
        
        let point1 = CGPoint(x: -width / 2, y: height / 2)
        let point2 = CGPoint(x: 0, y: -height / 2)
        let point3 = CGPoint(x: width / 2, y: height / 2)
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: height / 2))
            path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
            path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
            path.closeSubpath()
        }
    }
}

