//
//  Double.swift
//  Climb Up
//
//  Created by Bohdan on 17.11.2020.
//

import Foundation

extension Double {
  func asDateString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.unitsStyle = style
    if self > 0 {
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    } else {
        return ""
    }
  }
    func asDateStringWithSeconds(style: DateComponentsFormatter.UnitsStyle) -> String {
      let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
      formatter.unitsStyle = style
      if self > 0 {
          guard let formattedString = formatter.string(from: self) else { return "" }
          return formattedString
      } else {
          return ""
      }
    }
}
