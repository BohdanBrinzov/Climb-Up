//
//  ChartInteractor.swift
//  Climb Up
//
//  Created by Bohdan on 20.11.2020.
//

import Foundation
import Combine

class ChartInteractor: ObservableObject {
    
    // MARK: - Initial vars
    @Published var climbs: [Climb] = []
    
    // MARK: - Private const
    private let _coreDataManager = CoreDataManager.shared
    
    // MARK: - Private vars
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        // MARK: sink from entity
        _coreDataManager.climbsEntityPublisher
            .sink { (complition) in
                print(complition)
            } receiveValue: { (item) in
                self.climbs = item.map(Climb.init)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Work woth core data funcs
    func addAspiration(aspiration: Aspiration) {
        _coreDataManager.addAspiration(id: aspiration.id, name: aspiration.name, color: aspiration.color, date: aspiration.date)
    }
    
    func removeAspiration(at id: UUID) {
        _coreDataManager.removeAspiration(at: id)
    }
}
