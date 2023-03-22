//
//  MovingCounter.swift
//  ActivQue
//
//  Created by Bohdan on 16.10.2020.
//  Copyright © 2020 Bohdan Brinzov. All rights reserved.
//

import SwiftUI

struct StepperWithInterface: View {
    //FIXME: Do binding value
    @Binding var number: Int
    let textVisible: Bool
    let valueVisible: Bool
    
    //MARK: Steper values
    private let maxValueStepper: Int = 90
    private let minValueStepper: Int = 1
    private let oneStep: Int = 1
    
    //MARK: Propherty
    @State var frameHaight: CGFloat = 40
    @State var frameWidth: CGFloat = 120
    private let backgroundColor = Color.gray.opacity(0.03)
    private let cornerRadius: CGFloat = 20
    
    var body: some View {
        HStack(spacing: 0) {
            //MARK: - Button minus
            Rectangle()
                .overlay(Image(systemName: "minus").foregroundColor(.white))
                .cornerRadius(radius: cornerRadius, corners: [.topLeft, .bottomLeft])
                .foregroundColor(backgroundColor)
                .onTapGesture(count: 1, perform: {
                    self.minus()
                })
            //MARK: - Counter view
            if valueVisible {
                MovingCounter(number: Double(number), textVisible: textVisible)
                .frame(width: 60, height: 40, alignment: .center)
                .background(backgroundColor)
            }
            //MARK: - Button plus
            Rectangle()
                .cornerRadius(radius: cornerRadius, corners: [.topRight, .bottomRight])
                .overlay(Image(systemName: "plus").foregroundColor(.white))
                .foregroundColor(backgroundColor)
                .onTapGesture(count: 1, perform: {
                    self.plus()
                })
        }
        .cornerRadius(cornerRadius)
        .frame(width: frameWidth, height: frameHaight, alignment: .center)
    }
    
    private func plus() {
        if number != maxValueStepper {
            DispatchQueue.main.async {
                number += oneStep
                UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.5)
            }

        } else {
            //FIXME: Do alert to rest
            // MARK: Vibration
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.5)
        }
    }
    
    private func minus() {
        if number != minValueStepper {
            DispatchQueue.main.async {
                number -= oneStep
                UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.5)
            }
        } else {
            //FIXME: Add vibration
            // MARK: Vibration
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.5)
        }
    }
}
struct MovingCounter: View {
    let number: Double
    let textVisible: Bool
    
    var body: some View {
        Text("00")
            .modifier(MovingCounterModifier(textVisible: textVisible, number: number))
    }
    
    struct MovingCounterModifier: AnimatableModifier {
        @State private var height: CGFloat = 0
        let textVisible: Bool
        
        var number: Double
        
        var animatableData: Double {
            get { number }
            set { number = newValue }
        }
        
        func body(content: Content) -> some View {
            let n = self.number + 1
            
            let tOffset: CGFloat = getOffsetForTensDigit(n)
            let uOffset: CGFloat = getOffsetForUnitDigit(n)
            
            let u = [n - 2, n - 1, n + 0, n + 1, n + 2].map { getUnitDigit($0) }
            let x = getTensDigit(n)
            var t = [abs(x - 2), abs(x - 1), abs(x + 0), abs(x + 1), abs(x + 2)]
            t = t.map { getUnitDigit(Double($0)) }
            
            let font = Font.custom("Areal", size: 17).bold()
            
            return HStack(alignment: .center, spacing: 0) {
                VStack {
                    Text("\(t[0])").font(font)
                    Text("\(t[1])").font(font)
                    Text("\(t[2])").font(font)
                    Text("\(t[3])").font(font)
                    Text("\(t[4])").font(font)
                }.foregroundColor(Color.white.opacity(0.6)).modifier(ShiftEffect(pct: tOffset))
                VStack {
                    Text("\(u[0])").font(font)
                    Text("\(u[1])").font(font)
                    Text("\(u[2])").font(font)
                    Text("\(u[3])").font(font)
                    Text("\(u[4])").font(font)
                }.foregroundColor(Color.white.opacity(0.6)).modifier(ShiftEffect(pct: uOffset))
                if textVisible {
                    Text(" min")
                    .foregroundColor(Color.white.opacity(0.6))
                    .font(font)
                }
            }
            .clipShape(ClipShape())
        }
        
        func getUnitDigit(_ number: Double) -> Int {
            return abs(Int(number) - ((Int(number) / 10) * 10))
        }
        
        func getTensDigit(_ number: Double) -> Int {
            return abs(Int(number) / 10)
        }
        
        func getOffsetForUnitDigit(_ number: Double) -> CGFloat {
            return 1 - CGFloat(number - Double(Int(number)))
        }
        
        func getOffsetForTensDigit(_ number: Double) -> CGFloat {
            if getUnitDigit(number) == 0 {
                return 1 - CGFloat(number - Double(Int(number)))
            } else {
                return 0
            }
        }
        
    }
    
    struct ClipShape: Shape {
        func path(in rect: CGRect) -> Path {
            let r = rect
            let h = 25//(r.height / 5.0 + 28.0)
            var p = Path()
            
            let cr = CGRect(x: 0, y: (r.height - CGFloat(h)) / 2.0, width: r.width + 5, height: CGFloat(h))
            p.addRoundedRect(in: cr, cornerSize: CGSize(width: 0, height: 0.0))
            
            return p
        }
    }
    
    struct ShiftEffect: GeometryEffect {
        var pct: CGFloat = 1.0
        
        func effectValue(size: CGSize) -> ProjectionTransform {
            return .init(.init(translationX: 0, y: (size.height / 5.0) * pct))
        }
    }
}
