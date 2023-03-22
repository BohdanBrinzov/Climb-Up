//
//  Color + func -> rgba.swift
//  Climb Up
//
//  Created by Bohdan on 13.11.2020.
//

import Foundation
import SwiftUI

extension Color {
    
    // MARK: - Main colors
    static let mainBlue = Color.hex("#2eadd4ff")
    static let mainAqua = Color.hex("#2e9fadff")
    static let mainGreen = Color.hex("#246148ff")
    static let mainYellow = Color.hex("#f1cf78ff")
    static let mainOrange = Color.hex("#f5720aff")
    static let mainAquaDarkest = Color.hex("#057c80ff")
    static let mainOrangeLight = Color.hex("#fa9744ff")
    
    static let mainBackground = Color.rgba(r: 27, g: 27, b: 26, a: 1)
    static let mainBackgroundDark = Color.rgba(r: 10, g: 10, b: 10, a: 1)
    
    // MARK: - Support functions
    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> Color {
        return Color.init(UIColor(red: r/255, green: g/255, blue: b/255, alpha: a))
    }
    
    static func hex(_ value: String) -> Color {
        return Color.init(UIColor(hex: value) ?? .gray)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension Color {
    
    func getHEXString() -> String {
        
        switch self {
        case .mainBlue:
            return "#2eadd4ff"
        case .mainAqua:
            return "#2e9fadff"
        case .mainGreen:
            return "#246148ff"
        case .mainYellow:
            return "#f1cf78ff"
        case .mainOrange:
            return "#f5720aff"
        case .mainAquaDarkest:
            return "#057c80ff"
        case .mainOrangeLight:
            return "#fa9744ff"
        case .red:
            return "#C32532ff"
        default:
            return "#808080ff"
        }
    }
    
    
    func getWeight() -> Int {
        switch self {
        case .mainBlue:
            return 1
        case .mainAqua:
            return 2
        case .mainAquaDarkest:
            return 3
        case .mainGreen:
            return 4
        case .mainYellow:
            return 5
       case .mainOrangeLight:
           return 6
        case .mainOrange:
            return 7
        case .red:
            return 8
        default:
            return 9
        }
    }
}
