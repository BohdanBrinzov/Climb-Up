//
//  Climb.swift
//  Climb Up
//
//  Created by Bohdan on 10.11.2020.
//

import Foundation

final class Climb {
    
    let id: UUID
    
    @Published var date: Date
    @Published var quality: Int16?
    @Published var timeAll: Double?
    @Published var timeActive: Double?
    @Published var timeRest: Double?
    @Published var timeInterval: Double?
    @Published var aspiration: Aspiration?
    
    init(climb: ClimbEntity) {
        self.id = climb.id ?? UUID()
        self.date = climb.date ?? Date()
        self.quality = climb.quality
        self.timeAll = climb.timeAll
        self.timeActive = climb.timeActive
        self.timeInterval = climb.timeInterval
        self.timeRest = climb.timeRest
        guard let aspiration = climb.aspiration else {
            return
        }
        
        self.aspiration = Aspiration(aspiration: aspiration)
    }
    
    init(date: Date, quality: Int16?, timeAll: Double?, timeActive: Double?, timeRest: Double?, timeInterval: Double?, aspiration: Aspiration?) {
        
        self.id = UUID()
        self.date = date
        self.quality = quality
        self.timeAll = timeAll
        self.timeActive = timeActive
        self.timeRest = timeRest
        self.timeInterval = timeInterval
        self.aspiration = aspiration
    }
}

extension Climb: Equatable {
    static func == (lhs: Climb, rhs: Climb) -> Bool {
        lhs.id == rhs.id
    }
}

extension Climb: Identifiable {}

extension Climb: ObservableObject {}
