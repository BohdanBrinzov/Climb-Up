//
//  MainViewPresener.swift
//  ClimbUp
//
//  Created by Bohdan on 03.09.2020.
//  Copyright © 2020 Bohdan Brinzov. All rights reserved.
//

import Combine
import SwiftUI

class HomePresenter: ObservableObject {
    //  private let interactor: TripListInteractor
    //  private let router = TripListRouter()
    
    // MARK: - Button items menu
    @Published var draggingState: DraggingInterfaceState = .center
    @Published var finalDraggingState: DraggingInterfaceState = .center
    
    // MARK: - Timer values
    @Published var activeStapper: Int = 20
    @Published var restStepper: Int = 5
    @Published var lapsStepper: Int = 5
    @Published var intervalStepper: Int = 10
    @Published var onlyTimeStepper: Int = 5
    
    // MARK: Current Acpiration
    @Published var currentAcpiration: Aspiration!
    
    // MARK: Global position interface consts
    private let _leftBuffer: CGFloat
    private let _rightBuffer: CGFloat
    private let _leftPosition: CGFloat
    private let _rightPosition: CGFloat
    private let _centerPosition: CGFloat = 0
    
    private let toSwipeDistance: CGFloat = 75
    
    //MARK: - Global dragging variables
    @Published var startLocation: CGPoint!
    @Published var currentLocation: CGPoint!
    @Published var xOffsetDragging: CGFloat = 0
    
    //MARK: - Init consts presenter
    init() {
        self._leftBuffer = 80
        self._rightBuffer = -80
        self._leftPosition = -(UIScreen.main.bounds.width/2) + _leftBuffer
        self._rightPosition =  (UIScreen.main.bounds.width/2) + _rightBuffer
    }
    
    //MARK: - Main dragging functions
    func startDragging(startLocation location: CGPoint?) {
        if finalDraggingState == draggingState {
            self.startLocation = location
            finalDraggingState = draggingState
            draggingState = .active
        } else {
            draggingState = .active
            self.startLocation = location
            self.currentLocation.x = xOffsetDragging
        }
        
        //FIXME: Vibration
        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.5)
    }
    
    func dragging(byCurrentLocation location: CGPoint) {
        currentLocation = location
        
        let tempDiefernceLocations = Int((startLocation.x - currentLocation.x) * -1)
        
        if tempDiefernceLocations < 0 && finalDraggingState == .left {
            xOffsetDragging = CGFloat(tempDiefernceLocations / 3)
        } else if tempDiefernceLocations > 0 && finalDraggingState == .right {
            xOffsetDragging = CGFloat(tempDiefernceLocations / 3)
        } else {
            xOffsetDragging = CGFloat(tempDiefernceLocations)
        }
    }
    
    func endDragging() {
        //MARK: Right swipe
        if xOffsetDragging > toSwipeDistance {
            
            if finalDraggingState != .right{
                
                if finalDraggingState == .left {
                    finalDraggingState = .center
                } else if finalDraggingState == .center {
                    finalDraggingState = .right
                }
                draggingState = finalDraggingState
            }
        }
        
        //MARK: Left swipe
        if xOffsetDragging < -toSwipeDistance {
            
            if finalDraggingState != .left {
                if finalDraggingState == .center {
                    finalDraggingState = .left
                } else if finalDraggingState == .right {
                    finalDraggingState = .center
                }
                draggingState = finalDraggingState
            }
            
        }
        
        //MARK: finish dragging update variables
        startLocation = nil
        draggingState = finalDraggingState
        xOffsetDragging = 0
    }
}
