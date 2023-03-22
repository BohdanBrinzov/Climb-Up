//
//  AspirationsListRouter.swift
//  Climb Up
//
//  Created by Bohdan on 13.11.2020.
//

import Foundation
import SwiftUI

class AspirationListRouter {
    
    func makeAspirationView(for aspirationId: UUID) -> some View {
        let interactor = AspirationInteractor(aspirationId: aspirationId)
        let presenter = AspirationPresenter(interactor: interactor)
        return AspirationView(presenter: presenter)
    }
}
