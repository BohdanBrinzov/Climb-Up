//
//  AspirationInteractor.swift
//  Climb Up
//
//  Created by Bohdan on 17.11.2020.
//

import Foundation
import Combine

class AspirationInteractor: ObservableObject {
    
    // MARK: - Initial vars
    @Published var aspiration: Aspiration?
    @Published var climbs: [Climb] = []
    
    // MARK: - Private const
    private let _coreDataManager = CoreDataManager.shared
    
    // MARK: - Private vars
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(aspirationId: UUID) {
        // MARK: sink aspiration from entity
        _coreDataManager.aspirationsEntityPublisher
            .sink { (complition) in
                print(complition)
            } receiveValue: { [unowned self] (item) in
                let aspirations = item.map(Aspiration.init)
                
                let aspiration = aspirations.filter { (item) -> Bool in
                    item.id == aspirationId
                }
                
                self.aspiration = aspiration.first
            }
            .store(in: &cancellables)
        
        _coreDataManager.climbsEntityPublisher
            .sink { (complition) in
                print(complition)
            } receiveValue: { [unowned self] (item) in
                
                let climbs = item.map(Climb.init)
                
                let climbsFiltered = climbs.filter { (item) -> Bool in
                    item.aspiration?.id == aspirationId
                }
                
                self.climbs = climbsFiltered
            }
            .store(in: &cancellables)
    }
}
