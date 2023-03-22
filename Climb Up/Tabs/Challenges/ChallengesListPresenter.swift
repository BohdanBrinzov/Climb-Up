//
//  ChalengesPresenter.swift
//  Climb Up
//
//  Created by Bohdan on 03.12.2020.
//

import SwiftUI
import Combine

class ChallengesListPresenter: ObservableObject {
    
    private let interactor: ChallengesListInteractor
    private let router = ChallengesListRouter()
    
    // MARK: - Climbs
    @Published var climbs: [Climb] = []
    
    @Published var climbsCountArr: [Double] = []
    @Published var timeArr: [Double] = []
    @Published var activeArr: [Double] = []
    @Published var restArr: [Double] = []
    @Published var qualityArr: [Double] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(interactor: ChallengesListInteractor) {
        self.interactor = interactor
        
        // MARK: - All climbs
        interactor.$climbs
            .assign(to: \.climbs, on: self)
            .store(in: &cancellables)
        
        // MARK: - Arr challenge publishers
        $climbs
            .map({ item -> [Double] in
                
                var count: [Double] = []
                
                item.forEach({ (item) in
                    count.append(Double(1))
                })
                
                return count
            })
            .assign(to: \.climbsCountArr, on: self)
            .store(in: &cancellables)
        
        $climbs
            .map({ item -> [Double] in
                
                var totalTime: [Double] = []
                
                item.forEach({ (item) in
                    totalTime.append(Double(item.timeAll ?? 0))
                })
                
                return totalTime
            })
            .assign(to: \.timeArr, on: self)
            .store(in: &cancellables)
        
        $climbs
            .map({ item -> [Double] in
                
                var totalActivity: [Double] = []
                
                item.forEach({ (item) in
                    
                    totalActivity.append(Double(item.timeActive ?? 0))
                    
                })
                
                return totalActivity
            })
            .assign(to: \.activeArr, on: self)
            .store(in: &cancellables)
        
        $climbs
            .map({ item -> [Double] in
                
                var totalRest: [Double] = []
                
                item.forEach({ (item) in
                    
                    totalRest.append(Double(item.timeRest ?? 0))
                    
                })
                
                return totalRest
            })
            .assign(to: \.restArr, on: self)
            .store(in: &cancellables)
        
        $climbs
            .map({ item -> [Double] in
                
                var qualities: [Double] = []
                
                item.forEach({ (item) in
                    qualities.append(Double(item.quality ?? 0))
                })
                
                return qualities
            })
            .assign(to: \.qualityArr, on: self)
            .store(in: &cancellables)
    }
    
    
    // MARK: - Build links
    func linkBuilderClimbsCount<Content: View>(@ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeChallengeViewClimbsCount(forValues: climbsCountArr)) {
            content()
        }
    }
    
    func linkBuilderActiveTime<Content: View>(@ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeChallengeViewActiveTime(forValues: activeArr)) {
            content()
        }
    }
    
    func linkBuilderRestTime<Content: View>(@ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeChallengeViewRestTime(forValues: restArr)) {
            content()
        }
    }
    
    func linkBuilderClimbsTime<Content: View>(@ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeChallengeViewClimbsTime(forValues: timeArr)) {
            content()
        }
    }
    
    func linkBuilderQuality<Content: View>(@ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeChallengeViewQuality(forValues: qualityArr)) {
            content()
        }
    }
    
}

