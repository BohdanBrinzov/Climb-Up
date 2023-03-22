//
//  NotificationType.swift
//  Climb Up
//
//  Created by Bohdan on 14.12.2020.
//

import SwiftUI

enum NotificationType: String {
    case Interval = "Interval"
    case DoubleInterval = "DoubleInterval"
    case EndTimer = "EndTimer"
    case None = "None"
}


enum NotificationActionBtn: String {
    case None = "Nil"
    case IntervalSwitch = "IntervalSwitch"
    case SkipInterval = "SkipInterval"
    case EndTimer = "EndTimerBtn"
    case Quality60 = "Quality60"
    case Quality70 = "Quality70"
    case Quality80 = "Quality80"
    case Quality90 = "Quality90"
    case Quality95 = "Quality95"
    case Quality100 = "Quality100"
}
