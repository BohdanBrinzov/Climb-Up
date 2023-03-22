//
//  AspirationModel.swift
//  Climb Up
//
//  Created by Bohdan on 07.11.2020.
//

import Foundation
import SwiftUI

final class Aspiration {
    
    let id: UUID
    
    @Published var name: String = ""
    @Published var date: Date
    @Published var color: Color
    
    @Published var climbs: [Climb] = []
    
    init(aspiration: AspirationEntity) {
        self.id = aspiration.id ?? UUID()
        
        self.name = aspiration.name!
        self.date = aspiration.date ?? Date()
        self.color = Color.hex(aspiration.colorHexStr ?? "#246148ff")
        
        // FIXME: self.climbs is always contein nil values
        self.climbs = aspiration.climb?.allObjects as? [Climb] ?? []
        
    }
    
    init(name: String, color: Color, date: Date = Date()) {
        
        self.id = UUID()
        
        self.name = name
        self.color = color
        self.date = date
    }
}

extension Aspiration: Equatable {
  static func == (lhs: Aspiration, rhs: Aspiration) -> Bool {
    lhs.id == rhs.id
  }
}

extension Aspiration: Identifiable {}

extension Aspiration: ObservableObject {}
