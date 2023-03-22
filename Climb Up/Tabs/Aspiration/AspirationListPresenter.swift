//
//  AspirationListPresenter.swift
//  Climb Up
//
//  Created by Bohdan on 13.11.2020.
//

import Foundation
import SwiftUI
import Combine

class AspirationListPresenter: ObservableObject {
    
    private let interactor: AspirationListInteractor
    private let router = AspirationListRouter()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var aspirations: [Aspiration] = []
    
    init(interactor: AspirationListInteractor) {
        self.interactor = interactor
        
        interactor.$aspirations
            .map({ items -> [Aspiration] in
                // MARK: Filter by color Weight
                items.sorted { (asp1, asp2) -> Bool in
                    asp1.color.getWeight() < asp2.color.getWeight()
                }
            })
            .assign(to: \.aspirations, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Functions
    func addAspiration(aspiration: Aspiration) {
        interactor.addAspiration(aspiration: aspiration)
    }
    
    func removeAspiration(offsets: IndexSet)  {
        offsets.forEach { (index) in
            let aspiration = self.aspirations[index]
            interactor.removeAspiration(at: aspiration.id)
        }
    }
    
    // MARK: - Build views
    func makeAddAspirationView() -> some View {
        AspirationAddView(presenter: self)
    }
    
    func linkBuilder<Content: View>(for aspiration: Aspiration, @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeAspirationView(for: aspiration.id)) {
            content()
        }
    }
    
}

