//
//  HillView.swift
//  Climb Up
//
//  Created by Bohdan on 05.12.2020.
//

import SwiftUI

struct MainHillView: View {
    
    @Binding var draggingXValue: CGFloat
    @State var positionView: DraggingInterfaceState = .left
    
    private let finalWidth: CGFloat = UIScreen.main.bounds.width
    private let offsetYSpacing: CGFloat =  UIScreen.main.bounds.width / 3
    
    private let minValue: CGFloat = UIScreen.main.bounds.width * 0.5
    private let maxValue: CGFloat = 0
    
    private let animation: Animation = .mainAppAnimation()
    
    var body : some View {
        ZStack(alignment: .bottom) {
            finalView(draggingXValue: $draggingXValue)
                .offset(x: 0, y: offsetYSpacing + 3)
        }
        .frame(width: finalWidth, height: offsetYSpacing, alignment: .center)
        .animation(animation)
    }
    
    
    
    private func finalView(draggingXValue: Binding<CGFloat>) -> some View {
        
        return ZStack{
            hillView(draggingXValue: draggingXValue)
            
            if positionView == .left {
                linesView(draggingXValue: draggingXValue)
            }
            if positionView == .center {
                linesWithPointsView(draggingXValue: draggingXValue)
            }
            if positionView == .right {
                curvePathView(draggingXValue: draggingXValue)
            }
        }
    }
    
    private func hillView(draggingXValue: Binding<CGFloat>) -> some View {
        
        let lineGradient = RadialGradient(gradient: Gradient(colors: [Color.white, Color.white, Color.mainAquaDarkest]), center: .center, startRadius: finalWidth, endRadius: finalWidth / 2.3)
        let lineWidth: CGFloat = 4
        let opacity: Double = 0.4
        
        return ZStack {
            HillView(mainWidth: finalWidth, dragging: draggingXValue.wrappedValue)
                .fill(lineGradient)
                .opacity(opacity)
            HillView(mainWidth: finalWidth, dragging: draggingXValue.wrappedValue)
                .stroke(lineWidth: lineWidth)
                .fill(lineGradient)
                .opacity(opacity + 0.5)
        }
    }
    
    private func curvePathView(draggingXValue: Binding<CGFloat>) -> some View {
        
        let trimValue = draggingXValue.wrappedValue / 120
        let lineWidth: CGFloat = 0.5
        let lineDash: CGFloat = 4
        
        let color = Color.mainAquaDarkest
        
        return CurvePathView(mainWidth: finalWidth, dragging: draggingXValue.wrappedValue)
            .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [lineDash]))
            .trim(from: trimValue, to: 1)
            .fill(color)
    }
    
    private func linesView(draggingXValue: Binding<CGFloat>) -> some View {
        let trimValue = draggingXValue.wrappedValue / 120
        let lineWidth: CGFloat = 0.5
        let lineDash: CGFloat = 4
        
        let color = Color.mainAquaDarkest
        
        return LinesView(mainWidth: finalWidth, dragging: draggingXValue.wrappedValue)
                        .stroke(style: StrokeStyle( lineWidth: lineWidth, dash: [lineDash]))
                        .trim(from: trimValue, to: 1)
                        .fill(color)
    }
        
    private func linesWithPointsView(draggingXValue: Binding<CGFloat>) -> some View {
        let trimValue = draggingXValue.wrappedValue / 120
        let lineWidth: CGFloat = 0.5
        let lineDash: CGFloat = 4
        
        let opacutyValue = 1 - Double(draggingXValue.wrappedValue / 90)
        
        let color = Color.mainAquaDarkest
        
        return ZStack {
            LinesView(mainWidth: finalWidth, dragging: draggingXValue.wrappedValue)
                .stroke(style: StrokeStyle( lineWidth: lineWidth, dash: [lineDash]))
                .trim(from: trimValue, to: 1)
                .fill(color)
                .zIndex(2.0)
            CirclesView(mainWidth: finalWidth, dragging: draggingXValue.wrappedValue)
                .fill(color)
                .opacity(opacutyValue)
                .zIndex(1.0)
        }
    }
}

struct HillView: Shape {
    
    private var mainWidth: CGFloat
    private var dragging: CGFloat
    
    init(mainWidth: CGFloat,dragging: CGFloat ) {
        self.mainWidth = mainWidth
        self.dragging = dragging
    }
    
    internal var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(mainWidth, dragging) }
        set {
            mainWidth = newValue.first
            dragging = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        let hei: CGFloat = mainWidth * 0.42
        let wid: CGFloat = mainWidth * 0.42
        
        let finalHeight = hei + -dragging
        let xDraggingSlow = -dragging / 4
        
        let leftWidth = ((mainWidth + wid) / 2) - xDraggingSlow
        let rightWidth = ((mainWidth - wid) / 2) + xDraggingSlow
        
        let x1 = mainWidth * 0.53
        let x2 = mainWidth * 0.47
        
        let y1y2 = -( finalHeight )
        
        return Path { path in
            path.move(to: CGPoint(x: leftWidth, y: 0))
            path.addCurve(
                to: CGPoint(x: rightWidth, y: 0),
                control1: CGPoint(x: x1, y: y1y2),
                control2: CGPoint(x: x2, y: y1y2)
            )
        }
    }
}

struct LinesView: Shape {
    
    private var mainWidth: CGFloat
    private var dragging: CGFloat
    
    init(mainWidth: CGFloat,dragging: CGFloat ) {
        self.mainWidth = mainWidth
        self.dragging = dragging
    }
    
    internal var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(mainWidth, dragging) }
        set {
            mainWidth = newValue.first
            dragging = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        let meinWidth: CGFloat = mainWidth
        let midX = meinWidth / 2
        let height: CGFloat = meinWidth * 0.42
        
        let finalHeight: CGFloat = -dragging + height
        
        let firstLineY = -finalHeight / 6
        let firstLineX = midX - finalHeight * 0.43 + -dragging / 2
        
        let secondLineY = -finalHeight  / 2.9
        let secondLineX = midX - finalHeight * 0.33 + -dragging / 2
        
        let thirdLineY = -finalHeight / 1.9
        let thirdLineX = midX - finalHeight * 0.23 + -dragging / 2.5
        
        return Path { path in
            path.move(to: CGPoint(x: midX,y: firstLineY))
            path.addLine(to: CGPoint(x:firstLineX, y: firstLineY))
            
            path.move(to: CGPoint(x: midX,y: secondLineY))
            path.addLine(to: CGPoint(x: secondLineX,y: secondLineY))
            
            path.move(to: CGPoint(x: midX,y: thirdLineY))
            path.addLine(to: CGPoint(x: thirdLineX,y: thirdLineY))
        }
    }
    
}

struct CirclesView: Shape {
    
    private var mainWidth: CGFloat
    private var dragging: CGFloat
    
    init(mainWidth: CGFloat,dragging: CGFloat ) {
        self.mainWidth = mainWidth
        self.dragging = dragging
    }
    
    internal var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(mainWidth, dragging) }
        set {
            mainWidth = newValue.first
            dragging = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        let meinWidth: CGFloat = mainWidth
        let midX = meinWidth / 2 + dragging / 2
        let height: CGFloat = meinWidth * 0.42
        
        let finalHeight: CGFloat = -dragging + height
        
        let firstLineY = -finalHeight / 6
        
        let secondLineY = -finalHeight  / 2.9
        
        let thirdLineY = -finalHeight / 1.9
        
        return Path { path in
            path.move(to: CGPoint(x: midX,y: firstLineY))
            path.addArc(center:  CGPoint(x: midX,y: firstLineY), radius: 5, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
            
            
            path.move(to: CGPoint(x: midX,y: secondLineY))
            path.addArc(center:  CGPoint(x: midX,y: secondLineY), radius: 5, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
            
            
            path.move(to: CGPoint(x: midX,y: thirdLineY))
            path.addArc(center:  CGPoint(x: midX,y: thirdLineY), radius: 5, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
        }
    }
    
}

struct CurvePathView: Shape {
    
    private var mainWidth: CGFloat
    private var dragging: CGFloat
    
    init(mainWidth: CGFloat,dragging: CGFloat ) {
        self.mainWidth = mainWidth
        self.dragging = dragging
    }
    
    internal var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(mainWidth, dragging) }
        set {
            mainWidth = newValue.first
            dragging = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        let meinWidth: CGFloat = mainWidth
        let hei: CGFloat = meinWidth * 0.42
        let wid: CGFloat = meinWidth * 0.42
        
        let finalHeight = hei + -dragging / 1.3
        let leftWidth = ((meinWidth + wid) / 2) - -dragging
        let rightWidth = ((meinWidth - wid) / 2) + -dragging
        let startWidthPoint = leftWidth - wid * 0.10 + -dragging
        let end2CurvePoint = leftWidth - wid * 0.22 + -dragging
        
        let firstCurveX1 = meinWidth / 2 - wid * 0.15
        let firstCurveY1 = -finalHeight / 2.4
        let firstCurveControlY =  -finalHeight / 6
        let firstCurveControlX = -rightWidth / 3.6
        
        let secondCurveX = meinWidth / 2
        let secondCurveY = -finalHeight + hei * 0.25
        let secondCurveControlY =  -finalHeight / 2
        
        
        return Path { path in
            path.move(to: CGPoint(x: startWidthPoint, y: 0))
            path.addCurve(
                to: CGPoint(x: firstCurveX1, y: firstCurveY1),
                control1: CGPoint(x: firstCurveControlX, y: firstCurveControlY),
                control2: CGPoint(x: meinWidth, y: firstCurveControlY)
            )
            path.addCurve(
                to: CGPoint(x: secondCurveX, y: secondCurveY),
                control1: CGPoint(x: wid, y: secondCurveControlY),
                control2: CGPoint(x: end2CurvePoint, y: secondCurveControlY)
            )
        }
    }
}
