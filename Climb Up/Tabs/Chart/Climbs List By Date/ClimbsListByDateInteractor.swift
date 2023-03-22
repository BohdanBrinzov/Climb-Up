//
//  ClimbsListByDateInteractor.swift
//  Climb Up
//
//  Created by Bohdan on 21.11.2020.
//

import SwiftUI
import Combine

class ClimbsListByDateInteractor: ObservableObject {
    
    // MARK: - Initial vars
    @Published var date: Date
    
    @Published var climbs: [Climb] = []
    
    // MARK: - Private const
    private let _coreDataManager = CoreDataManager.shared
    
    // MARK: - Private vars
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(date: Date) {
        
        self.date = date
        
        // MARK: sink from entity
        _coreDataManager.climbsEntityPublisher
            .sink { (complition) in
                print(complition)
            } receiveValue: { (item) in
                
                let climbs = item.map(Climb.init)
                
                let climbsFiltered = climbs.filter { (item) -> Bool in
                    date.isSameDate(item.date)
                }
                
                self.climbs = climbsFiltered
            }
            .store(in: &cancellables)
    }
}
