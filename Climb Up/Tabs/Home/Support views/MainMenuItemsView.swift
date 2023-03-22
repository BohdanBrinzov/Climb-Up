//
//  MenuItems.swift
//  ClimbUp
//
//  Created by Bohdan on 08.09.2020.
//  Copyright © 2020 Bohdan Brinzov. All rights reserved.
//

import SwiftUI

struct MainMenuItemsView: View {
    
    // MARK: - Internal type
    typealias ButtonType = (name: String, draggingStateButtonPosition: DraggingInterfaceState)
    
    // MARK: - Constructor vars
    @Binding var draggingState: DraggingInterfaceState
    @Binding var previousDraggingState: DraggingInterfaceState
    @Binding var xOffsetDragging: CGFloat
    
    // MARK: - Internal vars
    @Namespace private var ns
    var buttonNamesArr: [ButtonType] = [("Interval", .left), ("Double interval", .center), ("Time only", .right)]
    
    // MARK: - Internal consts
    private let spacing: CGFloat = 30
    private let paddingBottom: CGFloat = 20
    private let cornerRadius: CGFloat = 20
    private let sliderColor: Color = Color.gray.opacity(0.3)
    private let sliderSizeWidth: CGFloat = 70
    private let sliderSizeHeight: CGFloat = 30
    
    
    // MARK: - Viewd internal functions
    private func computeOpacity() -> Double {
        return draggingState == .active ? 0.5 : 0.2
    }
    
    private var computeDragValue: Int {
        $previousDraggingState.wrappedValue.rawValue
    }
    
    private func computeOffestByX() -> CGFloat {
        return (xOffsetDragging  / 3)
    }
    
    private func animationView() -> Animation {
        return .mainAppAnimation()
    }
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            ButtonMenuItem(buttonName: buttonNamesArr[0], draggingState: $draggingState, previousDraggingState: $previousDraggingState, currentButton: 0)
                .matchedGeometryEffect(id: 0, in: ns)
                .frame(width: nil, height: nil, alignment: .leading)
            ButtonMenuItem(buttonName: buttonNamesArr[1], draggingState: $draggingState, previousDraggingState: $previousDraggingState, currentButton: 1)
                .matchedGeometryEffect(id: 1, in: ns)
                .frame(width: nil, height: nil, alignment: .center)
            ButtonMenuItem(buttonName: buttonNamesArr[2], draggingState: $draggingState, previousDraggingState: $previousDraggingState, currentButton: 2)
                .matchedGeometryEffect(id: 2, in: ns)
                .frame(width: nil, height: nil, alignment: .trailing)
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(sliderColor)
                .offset(x: computeOffestByX())
                .matchedGeometryEffect(id: computeDragValue, in: ns, isSource: false)
                .opacity(computeOpacity())
                .animation(self.animationView())
        )
        .padding(.bottom, paddingBottom)
    }
    
    // MARK: - Button item View
    struct ButtonMenuItem: View {
        
        // MARK: - Constructor vars
        let buttonName: ButtonType
        @Binding var draggingState: DraggingInterfaceState
        @Binding var previousDraggingState: DraggingInterfaceState
        
        let currentButton: Int
        
        // MARK: - Internal consts
        private let _textSize: CGFloat = 17
        private let _padding: CGFloat = 10
        private let _activeColor: Color = Color.white
        private let _notActiveColor: Color = Color.gray
        
        // MARK: - View
        var body: some View {
            Text(buttonName.name)
                .foregroundColor(draggingState == buttonName.draggingStateButtonPosition ? _activeColor : _notActiveColor)
                .font(.system(size: _textSize, weight: .medium, design: .rounded))
                .padding(_padding)
                .onTapGesture {
                    withAnimation(.mainAppAnimation()) {
                        DispatchQueue.main.async {
                            let stateDrag = buttonName.draggingStateButtonPosition
                            self.previousDraggingState = stateDrag
                            self.draggingState = stateDrag
                        }
                    }
                }
        }
    }
}

