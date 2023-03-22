//
//  MainHillsView.swift
//  Climb Up
//
//  Created by Bohdan on 05.12.2020.
//

import SwiftUI


struct MainHillsView: View {
    
    // MARK: - Constructor vars
    @Binding var draggingState: DraggingInterfaceState
    @Binding var previousDraggingState: DraggingInterfaceState
    @Binding var xOffsetDragging: CGFloat
    
    // MARK: - Hill position vars
    // MARK: Consts
    private let minHeightHill: CGFloat =  UIScreen.main.bounds.width * 0.5
    private let maxHeightHill: CGFloat = 0
    
    // MARK: Vars
    @State private var leftHillPosition: CGFloat = 0
    @State private var centerHillPosition: CGFloat = UIScreen.main.bounds.width * 0.2
    @State private var rightHillPosition: CGFloat = UIScreen.main.bounds.width * 0.2
    
    private let widthDistance = UIScreen.main.bounds.width * 0.8
    private let offsetYSpacing: CGFloat =  UIScreen.main.bounds.width / 3
    
    // MARK: - functions hills
    
    private func viewsOffset() -> CGSize {
        viewCenterXOffset()
        viewLeftXOffset()
        viewRightXOffset()
        
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
    
    private func viewLeftXOffset() {
        let slowDragging = xOffsetDragging / 2
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.sync {
                switch (draggingState, previousDraggingState) {
                case (.left, .left):
                    leftHillPosition = maxHeightHill
                case (.center, .center):
                    leftHillPosition = minHeightHill
                case (.right, .right) :
                    leftHillPosition =  minHeightHill
                case (.active, .left):
                    if xOffsetDragging < 0 {
                        
                        leftHillPosition =  (maxHeightHill - slowDragging)
                    } else {
                        
                        leftHillPosition =  (maxHeightHill + slowDragging)
                    }
                case (.active, .center):
                    leftHillPosition =  (minHeightHill + slowDragging)
                case (.active, .right):
                    leftHillPosition =  minHeightHill
                default:
                    leftHillPosition =  minHeightHill
                }
            }
        }
    }
    
    private func viewCenterXOffset() {
        let slowDragging = xOffsetDragging / -2
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.sync {
                switch (draggingState, previousDraggingState) {
                case (.left, .left):
                    centerHillPosition = minHeightHill
                case (.center, .center):
                    centerHillPosition = maxHeightHill
                case (.right, .right) :
                    centerHillPosition = minHeightHill
                case (.active, .left):
                    centerHillPosition = (minHeightHill + slowDragging)
                case (.active, .center):
                    if xOffsetDragging > 0 {
                        centerHillPosition = (maxHeightHill - slowDragging)
                    } else {
                        centerHillPosition = (maxHeightHill + slowDragging)
                    }
                case (.active, .right):
                    centerHillPosition = (minHeightHill - slowDragging)
                default:
                    centerHillPosition = minHeightHill
                }
            }
        }
    }
    private func viewRightXOffset() {
        let slowDragging = xOffsetDragging / -2
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.sync {
                switch (draggingState, previousDraggingState) {
                case (.left, .left):
                    rightHillPosition = minHeightHill
                case (.center, .center):
                    rightHillPosition = minHeightHill
                case (.right, .right) :
                    rightHillPosition = maxHeightHill
                case (.active, .left):
                    rightHillPosition = minHeightHill
                case (.active, .center):
                    rightHillPosition = (minHeightHill + slowDragging)
                case (.active, .right):
                    if xOffsetDragging < 0 {
                        rightHillPosition = (maxHeightHill + slowDragging)
                    } else {
                        rightHillPosition = (maxHeightHill - slowDragging)
                    }
                default:
                    rightHillPosition = minHeightHill
                }
            }
        }
    }
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            MainHillView(draggingXValue: $rightHillPosition, positionView: .right)
                .frame(width: widthDistance, height: offsetYSpacing, alignment: .center)
            MainHillView(draggingXValue: $centerHillPosition, positionView: .center)
                .frame(width: widthDistance, height: offsetYSpacing, alignment: .center)
            MainHillView(draggingXValue: $leftHillPosition, positionView: .left)
                .frame(width: widthDistance, height: offsetYSpacing, alignment: .center)
        }
        .offset(viewsOffset())
    }
}
