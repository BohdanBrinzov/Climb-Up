//
//  EndDragState.swift
//  ActivQue
//
//  Created by Bohdan on 28.08.2020.
//  Copyright © 2020 Bohdan Brinzov. All rights reserved.
//

import Foundation

// MARK: RawValue используются для анимации на главном меню как индекс в массиве имен кнопок
// FIXME:  Исправить описание
indirect enum DraggingInterfaceState: Int {
    case active = -1
    case left
    case center
    case right
    case autoDragging
}
