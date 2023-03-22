//
//  AspirationPresenter.swift
//  Climb Up
//
//  Created by Bohdan on 17.11.2020.
//

import Foundation
import Combine

class AspirationPresenter: ObservableObject {
    
    typealias TotalClimbValues = (totalTime: Double, totalActive: Double, totalRest: Double, averageQuality: Double)
    
    private let interactor: AspirationInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var aspiration: Aspiration?
    @Published var climbs: [Climb] = []
    @Published var qualities: [Double] = []
    @Published var totalValues: (totalTime: Double, totalActive: Double, totalRest: Double, averageQuality: Double) = (0, 0, 0, 0)
    
    init(interactor: AspirationInteractor) {
        self.interactor = interactor
        
        interactor.$aspiration
            .assign(to: \.aspiration, on: self)
            .store(in: &cancellables)
        
        interactor.$climbs
            .map({ (climbs) -> [Climb] in
                // MARK: sort by date
                climbs.sorted(by: { (climbPrevious, climbNext) -> Bool in
                    climbPrevious.date.timeIntervalSince1970 > climbNext.date.timeIntervalSince1970
                })
            })
            .assign(to: \.climbs, on: self)
            .store(in: &cancellables)
        
        interactor.$climbs
            .map({ item -> AspirationPresenter.TotalClimbValues in
                // MARK: calculate total values
                var totalTime: Double = 0
                var totalActive: Double = 0
                var totalRest: Double = 0
                var averageQuality: Double = 0
                
                let count = item.count
                var countZeroQualities = 0
                item.forEach({ (item) in
                    totalTime += item.timeAll ?? 0
                    totalActive += item.timeActive ?? 0
                    totalRest += item.timeRest ?? 0
                    
                    if item.quality ?? -1 > 0 {
                        averageQuality += Double(item.quality ?? 0)
                    } else {
                        countZeroQualities += 1
                    }
                })
                
                if averageQuality > 0 {
                    averageQuality = averageQuality / Double(count - countZeroQualities)
                }
                
                return (totalTime: totalTime, totalActive: totalActive, totalRest: totalRest, averageQuality: averageQuality)
            })
            .assign(to: \.totalValues, on: self)
            .store(in: &cancellables)
        
        interactor.$climbs
            .map({ item -> [Double] in
                
                var qualities: [Double] = []
                
                // MARK: sort by date
                let sorteredByDate = item.sorted(by: { (climbPrevious, climbNext) -> Bool in
                    climbPrevious.date.timeIntervalSince1970 < climbNext.date.timeIntervalSince1970
                })
                
                sorteredByDate.forEach({ (item) in
                    if item.quality != nil {
                        qualities.append(Double(item.quality ?? 0))
                    }
                })
                
                return qualities
            })
            .assign(to: \.qualities, on: self)
            .store(in: &cancellables)
    }
}
