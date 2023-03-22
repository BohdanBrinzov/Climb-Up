//
//  ChartRouter.swift
//  Climb Up
//
//  Created by Bohdan on 20.11.2020.
//

import SwiftUI

class ChartRouter {
    
    func makeClimbsListByDateView(for date: Date) -> some View {
        let interactor = ClimbsListByDateInteractor(date: date)
        let presenter = ClimnsListByDatePresenter(interactor: interactor)
        return ClimbsListByDateView(presenter: presenter).colorScheme(.dark)
    }
}
