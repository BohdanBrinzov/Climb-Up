//
//  MainManu.swift
//  ClimbUp
//
//  Created by Bohdan on 28.08.2020.
//  Copyright © 2020 Bohdan Brinzov. All rights reserved.
//

import SwiftUI


struct HomeView: View {
    
    // MARK: - Presenter
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        // MARK: - Gesture
        let dragGesture = DragGesture(minimumDistance: 10, coordinateSpace: .global)
            .onChanged( { value in
                DispatchQueue.main.async {
                    if presenter.startLocation == nil {
                        presenter.startDragging(startLocation: value.location)
                    }
                    presenter.dragging(byCurrentLocation: value.location)
                }
            } )
            .onEnded( { _ in
                DispatchQueue.main.async {
                    presenter.endDragging()
                }
            } )
        
        // MARK: - View return
        return VStack {
            Rectangle()
                .foregroundColor(Color.black)
            MainSceneView(draggingState: $presenter.draggingState, previousDraggingState: $presenter.finalDraggingState, xOffsetDragging: $presenter.xOffsetDragging)
                .padding(.top, -10)
            MainMenuItemsView(draggingState: $presenter.draggingState, previousDraggingState: $presenter.finalDraggingState, xOffsetDragging: $presenter.xOffsetDragging)
            PropertyMenu(draggingState: $presenter.draggingState, previousDraggingState: $presenter.finalDraggingState, xOffsetDragging: $presenter.xOffsetDragging, activeStapper: $presenter.activeStapper, restStepper: $presenter.restStepper, lapsStepper: $presenter.lapsStepper, intervalStepper: $presenter.intervalStepper, onlyTimeStepper: $presenter.onlyTimeStepper)
            Rectangle()
                .foregroundColor(Color.mainBackground)
            PlayView(draggingState: $presenter.draggingState, activeStapper: $presenter.activeStapper, restStepper:  $presenter.restStepper, lapsStepper:  $presenter.lapsStepper, intervalStepper:  $presenter.intervalStepper, onlyTimeStepper: $presenter.onlyTimeStepper)
        }
        .frame(minWidth: UIScreen.main.bounds.width, idealWidth: UIScreen.main.bounds.width, maxWidth: .infinity, minHeight: 0, idealHeight: UIScreen.main.bounds
                .height + 40, maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.mainBackground)
        .gesture(dragGesture)
    }
}

struct MainManu_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(presenter: HomePresenter())
    }
}
