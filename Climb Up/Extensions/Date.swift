//
//  Date.swift
//  Climb Up
//
//  Created by Bohdan on 18.11.2020.
//

import Foundation
import SwiftUI

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func isSameDate(_ comparisonDate: Date) -> Bool {
      let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
      return order == .orderedSame
    }
    
    func isSameMonth(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .month)
      return order == .orderedSame
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

