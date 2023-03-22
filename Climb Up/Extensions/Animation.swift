//
//  Animation.swift
//  Climb Up
//
//  Created by Bohdan on 05.12.2020.
//

import SwiftUI

extension Animation {
    static func mainAppAnimation() -> Animation {
        Animation.spring(dampingFraction: 0.95)
    }
}
