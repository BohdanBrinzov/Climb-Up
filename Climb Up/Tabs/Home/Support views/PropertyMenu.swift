//
//  PropheryMenu.swift
//  ClimbUp
//
//  Created by Bohdan on 15.10.2020.
//  Copyright © 2020 Bohdan Brinzov. All rights reserved.
//

import SwiftUI

struct PropertyMenu: View {
    
    // MARK: - Constructor vars
    @Binding var draggingState: DraggingInterfaceState
    @Binding var previousDraggingState: DraggingInterfaceState
    @Binding var xOffsetDragging: CGFloat
    
    @Binding var activeStapper: Int
    @Binding var restStepper: Int
    @Binding var lapsStepper: Int
    @Binding var intervalStepper: Int
    @Binding var onlyTimeStepper: Int
    
    private let widthDistance = UIScreen.main.bounds.width
    
    private func viewsOffset() -> CGSize {
        let dragging = xOffsetDragging
        let widthFirstDistance = -widthDistance
        
        switch (draggingState, previousDraggingState) {
        case (.left, .left):
            return CGSize(width: widthFirstDistance, height: 0)
        case (.center, .center):
            return CGSize(width: widthFirstDistance + widthDistance, height: 0)
        case (.right, .right) :
            return CGSize(width: widthFirstDistance + widthDistance + widthDistance, height: 0)
        case (.active, .left):
            return CGSize(width: widthFirstDistance + dragging, height: 0)
        case (.active, .center):
            return CGSize(width: widthFirstDistance + widthDistance + dragging, height: 0)
        case (.active, .right):
            return CGSize(width: widthFirstDistance + widthDistance + widthDistance + dragging, height: 0)
        default:
            return CGSize.zero
        }
    }
    
    
    // MARK: View
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            PropertyView(position: .right, activeStapper: $activeStapper, restStepper: $restStepper, lapsStepper: $lapsStepper, intervalStepper: $intervalStepper, onlyTimeStepper: $onlyTimeStepper)
            PropertyView(position: .center, activeStapper: $activeStapper, restStepper: $restStepper, lapsStepper: $lapsStepper, intervalStepper: $intervalStepper, onlyTimeStepper: $onlyTimeStepper)
            PropertyView(position: .left, activeStapper: $activeStapper, restStepper: $restStepper, lapsStepper: $lapsStepper, intervalStepper: $intervalStepper, onlyTimeStepper: $onlyTimeStepper)
        }
        .animation(.mainAppAnimation())
        .offset(viewsOffset())
    }
}

// MARK: Support view
struct PropertyView: View {
    
    let position: DraggingInterfaceState
    
    // MARK: - Internal consts
    private let paddingDistance: CGFloat = 10
    private let singleScreenWidth : CGFloat = UIScreen.main.bounds.width - 35
    private let height: CGFloat = 290
    
    @Binding var activeStapper: Int
    @Binding var restStepper: Int
    @Binding var lapsStepper: Int
    @Binding var intervalStepper: Int
    @Binding var onlyTimeStepper: Int
    
    
    var intervalFullTime: Double {
        Double(lapsStepper * (intervalStepper * 60))
    }
    
    var onlyTimeFull: Double {
        Double(onlyTimeStepper * 5 * 60)
    }

    
    // MARK: View
    var body: some View {
        VStack{
        VStack(alignment: .leading, spacing: 15) {
            if position != .center {
            HStack{
                Text("Total time")
                    .padding(.leading, 15)
                    .foregroundColor(Color.white.opacity(0.8))
                     .font(Font.custom("Gotham Pro", size: 17))
                Spacer()
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(width: 120)
                    .foregroundColor(Color.gray.opacity(0.03))
                    .overlay(
                        Text(position == .left ? "\(intervalFullTime.asDateString(style: .short))" : "\(onlyTimeFull.asDateString(style: .short))" )
                            .foregroundColor(Color.white.opacity(0.8))
                    )
            }
            .frame(width: singleScreenWidth - 20, height: 40, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(Color.gray.opacity(0.03)))
            .padding(10)
            .frame(width: singleScreenWidth, height: 40, alignment: .center)
            }
            
            if position == .left {
            HStack{
                Text("Laps")
                    .padding(.leading, 15)
                    .foregroundColor(Color.white.opacity(0.8))
                     .font(Font.custom("Gotham Pro", size: 17))
                Spacer()
                StepperWithInterface(number: $lapsStepper, textVisible: false, valueVisible: true)
            }
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(Color.gray.opacity(0.03)))
            .padding(10)
            .frame(width: singleScreenWidth, height: 40, alignment: .center)
            }
            
            if position == .center{
                HStack{
                    Text("Active")
                        .padding(.leading, 15)
                        .foregroundColor(Color.white.opacity(0.8))
                         .font(Font.custom("Gotham Pro", size: 17))
                    Spacer()
                    StepperWithInterface(number: $activeStapper, textVisible: true, valueVisible: true)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                        .foregroundColor(Color.gray.opacity(0.03)))
                .padding(10)
                .frame(width: singleScreenWidth, height: 40, alignment: .center)
                HStack{
                    Text("Rest")
                        .padding(.leading, 15)
                        .foregroundColor(Color.white.opacity(0.8))
                        .font(Font.custom("Gotham Pro", size: 17))
                    Spacer()
                    StepperWithInterface(number: $restStepper, textVisible: true, valueVisible: true)
                }.background(
                    RoundedRectangle(cornerRadius: 20.0)
                        .foregroundColor(Color.gray.opacity(0.03)))
                .padding(10)
                .frame(width: singleScreenWidth, height: 40, alignment: .center)
            }

            if position == .left {
                HStack{
                    Text("Interval")
                        .padding(.leading, 15)
                        .foregroundColor(Color.white.opacity(0.8))
                        .font(Font.custom("Gotham Pro", size: 17))
                    Spacer()
                    StepperWithInterface(number: $intervalStepper, textVisible: true, valueVisible: true)
                }.background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .foregroundColor(Color.gray.opacity(0.03))
                    })
                .padding(10)
                .frame(width: singleScreenWidth, height: 40, alignment: .center)
            }
            
            if position == .right {
                StepperWithInterface(number: $onlyTimeStepper, textVisible: false, valueVisible: false, frameWidth: singleScreenWidth - paddingDistance * 2)
                    .padding(.leading, paddingDistance)
            }
        }
        .padding(paddingDistance)
        .frame(minWidth: singleScreenWidth + 35, idealWidth: singleScreenWidth + 35, maxWidth: singleScreenWidth + 35, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: singleScreenWidth, alignment: .center)
                .foregroundColor(Color.mainAqua.opacity(0.2))
                .opacity(0.2)
        )
    }
    }
}
