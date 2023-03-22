//
//  File.swift
//  Climb Up
//
//  Created by Bohdan on 01.12.2020.
//

import Foundation
import SwiftUI

class ClimbsListByDateRouter {
    
    func makeAspirationView(for aspirationId: UUID) -> some View {
        let interactor = AspirationInteractor(aspirationId: aspirationId)
        let presenter = AspirationPresenter(interactor: interactor)
        return AspirationView(presenter: presenter).colorScheme(.dark)
    }
}
