//
//  AspirationsInteractor.swift
//  Climb Up
//
//  Created by Bohdan on 06.11.2020.
//

import Combine
import SwiftUI

class AspirationListInteractor: ObservableObject {
    
    // MARK: - Initial vars
    @Published var aspirations: [Aspiration] = []
    
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
    
    func removeAspiration(at id: UUID) {
        _coreDataManager.removeAspiration(at: id)
    }
}
