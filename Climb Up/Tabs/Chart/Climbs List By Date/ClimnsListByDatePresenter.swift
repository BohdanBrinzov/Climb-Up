//
//  ClimnsListByDatePresenter.swift
//  Climb Up
//
//  Created by Bohdan on 21.11.2020.
//

import Foundation
import Combine
import SwiftUI

class ClimnsListByDatePresenter: ObservableObject {
    
    typealias TotalClimbValues = (totalTime: Double, totalActive: Double, totalRest: Double, averageQuality: Double)
    
    private let interactor: ClimbsListByDateInteractor
    private let router = ClimbsListByDateRouter()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentDate: Date = Date()
    @Published var climbs: [Climb] = []
    @Published var totalValues: (totalTime: Double, totalActive: Double, totalRest: Double, averageQuality: Double) = (0, 0, 0, 0)
    
    init(interactor: ClimbsListByDateInteractor) {
        self.interactor = interactor
        
        interactor.$date
            .assign(to: \.currentDate, on: self)
            .store(in: &cancellables)
        
        interactor.$climbs
            .assign(to: \.climbs, on: self)
            .store(in: &cancellables)
        
        interactor.$climbs
            .map({ item -> AspirationPresenter.TotalClimbValues in
                
               var totalTime: Double = 0
               var totalActive: Double = 0
               var totalRest: Double = 0
               var averageQuality: Double = 0
            
                let count = item.count
                
                item.forEach({ (item) in
                    totalTime += item.timeAll ?? 0
                    totalActive += item.timeActive ?? 0
                    totalRest += item.timeRest ?? 0
                    averageQuality += Double(item.quality ?? 0)
                })
                
                if averageQuality > 0 {
                    averageQuality = averageQuality / Double(count)
                }
                
                return (totalTime: totalTime, totalActive: totalActive, totalRest: totalRest, averageQuality: averageQuality)
            })
            .assign(to: \.totalValues, on: self)
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(for aspirationId: UUID?, @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeAspirationView(for: aspirationId ?? UUID())) {
            content()
        }
    }
}
