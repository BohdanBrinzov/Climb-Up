//
//  ChalengesInteractor.swift
//  Climb Up
//
//  Created by Bohdan on 03.12.2020.
//

import SwiftUI
import Combine

class ChallengesListInteractor: ObservableObject {

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
}
