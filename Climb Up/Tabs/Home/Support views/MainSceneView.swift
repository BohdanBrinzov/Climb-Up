//
//  MainSceneView.swift
//  Climb Up
//
//  Created by Bohdan on 05.12.2020.
//

import SwiftUI

struct MainSceneView: View {
    
    // MARK: - Constructor vars
    @Binding var draggingState: DraggingInterfaceState
    @Binding var previousDraggingState: DraggingInterfaceState
    @Binding var xOffsetDragging: CGFloat
    
    // MARK: - Inthernal vars
    private let heightView: CGFloat = UIScreen.main.bounds.width * 0.45
    private let imageHeight: CGFloat = UIScreen.main.bounds.width / 4
    private let widthView: CGFloat = UIScreen.main.bounds.width
    
    // MARK: - View
    var body: some View {
        VStack{
            ZStack(alignment: .bottom) {
                MainHillsView(draggingState: $draggingState, previousDraggingState: $previousDraggingState, xOffsetDragging: $xOffsetDragging)
                    .offset(y: -imageHeight + 50)
                    .zIndex(2)
                Image("HomeBackgroundFront")
                    .resizable()
                    .frame(width: widthView, height: imageHeight, alignment: .bottom)
                    .zIndex(3)
                Image("HillsBack")
                    .resizable()
                    .frame(width: widthView, height: imageHeight * 1.35, alignment: .bottom)
                    .zIndex(1)
                
            }
            .frame(width: widthView, height: heightView, alignment: .bottom)
            .background(Color.black)
            .animation(.mainAppAnimation())
        }
    }
}

//#if DEBUG
struct MainSceneView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainSceneView(draggingState: .constant(.left),  previousDraggingState: .constant(.left), xOffsetDragging: .constant(0))
    }
}
