//
//  ClimbInteractor.swift
//  Climb Up
//
//  Created by Bohdan on 15.12.2020.
//

import SwiftUI
import Combine

class ClimbInteractor {
    
    // MARK: - Initial vars
    @Published private var aspirations: [Aspiration] = []
    
    // MARK: - Private const
    private let _coreDataManager = CoreDataManager.shared
    
    // MARK: - Private vars
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        // MARK: sink aspirations list from entity
        _coreDataManager.aspirationsEntityPublisher
            .sink { (complition) in
                print(complition)
            } receiveValue: { (item) in
                let aspirations = item.map(Aspiration.init)
                self.aspirations = aspirations
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Work woth core data funcs
    func addAspiration(aspiration: Aspiration) {
        _coreDataManager.addAspiration(id: aspiration.id, name: aspiration.name, color: aspiration.color, date: aspiration.date)
    }
    
    func addClimb(toAspiration: Aspiration, climb: Climb) {
        _coreDataManager.addClimbToAspiration(by: toAspiration.id, climbDate: Date(), climbQuality: Double(climb.quality ?? 0), climbTimeActive: climb.timeActive ?? 0, climbTimeAll: climb.timeAll ?? 0, climbTimeRest: climb.timeRest ?? 0, climbTimeInterval: climb.timeInterval ?? 0)
    }
    
    func getAspiration(byName name: String) -> Aspiration? {
        
        let aspirationFilter = aspirations.filter { Aspiration -> Bool in
            Aspiration.name.contains(name)
        }
        
        return aspirationFilter.first
    }
    
    func removeAspiration(at id: UUID) {
        _coreDataManager.removeAspiration(at: id)
    }
    
    func removeClimb(ad id: UUID) {
        _coreDataManager.removeClimb(by: id)
    }
}
