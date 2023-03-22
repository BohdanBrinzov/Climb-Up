//
//  ChalengesRouter.swift
//  Climb Up
//
//  Created by Bohdan on 03.12.2020.
//

import SwiftUI

class ChallengesListRouter {
    
    func makeChallengeViewClimbsCount(forValues arr: [Double]) -> some View {
        let presenter = ChallengePresenter(currentChallenge: .ClimbsCount, values: arr)
        return ChallengeView(title: "Climbs count", mainColor: Color.mainGreen, presenter: presenter).colorScheme(.dark)
    }
    
    func makeChallengeViewActiveTime(forValues arr: [Double]) -> some View {
        let presenter = ChallengePresenter(currentChallenge: .ActiveTime, values: arr)
        return ChallengeView(title: "Active", mainColor: Color.mainOrange.opacity(0.8), presenter: presenter).colorScheme(.dark)
    }
    
    func makeChallengeViewRestTime(forValues arr: [Double]) -> some View {
        let presenter = ChallengePresenter(currentChallenge: .RestTime, values: arr)
        return ChallengeView(title: "Rest", mainColor: Color.mainBlue, presenter: presenter).colorScheme(.dark)
    }
    
    func makeChallengeViewClimbsTime(forValues arr: [Double]) -> some View {
        let presenter = ChallengePresenter(currentChallenge: .ClimbsTime, values: arr)
        return ChallengeView(title: "Climb time", mainColor: Color.mainAqua, presenter: presenter).colorScheme(.dark)
    }
    
    func makeChallengeViewQuality(forValues arr: [Double]) -> some View {
        let presenter = ChallengePresenter(currentChallenge: .Quality, values: arr)
        return ChallengeView(title: "Quality", mainColor: Color.mainAquaDarkest, presenter: presenter).colorScheme(.dark)
    }
}
