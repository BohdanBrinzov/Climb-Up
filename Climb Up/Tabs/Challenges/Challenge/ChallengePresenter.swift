//
//  ChalengePresenter.swift
//  Climb Up
//
//  Created by Bohdan on 03.12.2020.
//

import SwiftUI


class ChallengePresenter: ObservableObject {
    
    typealias ChallengeType = (id: Int, imageName: String, imageSize: CGSize, titleName: String, currentValue: Int, finalValue: Int, isActive: Bool, percent: CGFloat)
    
    private let width = UIScreen.main.bounds.width / 2.3
    
    @Published var challengesList: [ChallengeType] = []
    
    init(currentChallenge: Challenge, values: [Double]) {
        
        switch currentChallenge {
        case .ClimbsCount:
            calculateClimbsCountChallenge(values)
        case .ActiveTime:
            calculateActiveTimeChallenge(values)
        case .RestTime:
            calculateRestTimeChallenge(values)
        case .ClimbsTime:
            calculateClimbsTimeChallenge(values)
        case .Quality:
            calculateQualityChallenge(values)
        }
    }
    
    private func calculateClimbsCountChallenge(_ values: [Double]) {
        
        let sumValues: Double = values.reduce(0, {$0 + $1})
        
        let finalValue1 = 15
        let finalValue2 = 30
        let finalValue3 = 60
        let finalValue4 = 120
        let finalValue5 = 240
        
        
        let percent1: CGFloat = CGFloat((Double(sumValues) / (Double(finalValue1) / 100)) / 100)
        let percent2: CGFloat = CGFloat((Double(Int(sumValues) - finalValue1) / (Double(finalValue2 - finalValue1) / 100)) / 100)
        let percent3: CGFloat = CGFloat((Double(Int(sumValues) - finalValue2) / (Double(finalValue3 - finalValue2) / 100)) / 100)
        let percent4: CGFloat = CGFloat((Double(Int(sumValues) - finalValue3) / (Double(finalValue4 - finalValue3) / 100)) / 100)
        let percent5: CGFloat = CGFloat((Double(Int(sumValues) - finalValue4) / (Double(finalValue5 - finalValue4) / 100)) / 100)
        
        let isActive1 = Int(sumValues) < finalValue1  ? true : false
        let isActive2 = Int(sumValues) < finalValue2 && Int(sumValues) > finalValue1  ? true : false
        let isActive3 = Int(sumValues) < finalValue3 && Int(sumValues) > finalValue2  ? true : false
        let isActive4 = Int(sumValues) < finalValue4 && Int(sumValues) > finalValue3  ? true : false
        let isActive5 = Int(sumValues) < finalValue5 && Int(sumValues) > finalValue4  ? true : false
        
        challengesList.append((id: 0, imageName: "Footwear", imageSize: CGSize(width: width / 1.9, height: width / 1.9), titleName: "Climbs count", currentValue: Int(sumValues), finalValue: finalValue1, isActive: isActive1, percent: percent1))
        challengesList.append((id: 1, imageName: "Glasses", imageSize: CGSize(width: width / 1.5, height: width / 3), titleName: "Climbs count", currentValue: Int(sumValues), finalValue: finalValue2, isActive: isActive2, percent: percent2))
        challengesList.append((id: 2, imageName: "Jacket", imageSize: CGSize(width: width / 1.5, height: width / 1.5), titleName: "Climbs count", currentValue: Int(sumValues), finalValue: finalValue3, isActive: isActive3, percent: percent3))
        challengesList.append((id: 3, imageName: "Scarf", imageSize: CGSize(width: width / 2, height: width / 1.3), titleName: "Climbs count", currentValue: Int(sumValues), finalValue: finalValue4, isActive: isActive4, percent: percent4))
        challengesList.append((id: 4, imageName: "Mittens", imageSize: CGSize(width: width / 2.1, height: width / 1.4), titleName: "Climbs count", currentValue: Int(sumValues), finalValue: finalValue5, isActive: isActive5, percent: percent5))
    }
    
    private func calculateActiveTimeChallenge(_ values: [Double]) {
        
        
        var sumValues: Double = values.reduce(0, {$0 + $1})
        
        sumValues = sumValues / 3600
        
        let finalValue1 = 30
        let finalValue2 = 60
        let finalValue3 = 120
        let finalValue4 = 240
        let finalValue5 = 480
        
        
        let percent1: CGFloat = CGFloat((Double(sumValues) / (Double(finalValue1) / 100)) / 100)
        let percent2: CGFloat = CGFloat((Double(Int(sumValues) - finalValue1) / (Double(finalValue2 - finalValue1) / 100)) / 100)
        let percent3: CGFloat = CGFloat((Double(Int(sumValues) - finalValue2) / (Double(finalValue3 - finalValue2) / 100)) / 100)
        let percent4: CGFloat = CGFloat((Double(Int(sumValues) - finalValue3) / (Double(finalValue4 - finalValue3) / 100)) / 100)
        let percent5: CGFloat = CGFloat((Double(Int(sumValues) - finalValue4) / (Double(finalValue5 - finalValue4) / 100)) / 100)
        
        let isActive1 = Int(sumValues) < finalValue1  ? true : false
        let isActive2 = Int(sumValues) < finalValue2 && Int(sumValues) > finalValue1  ? true : false
        let isActive3 = Int(sumValues) < finalValue3 && Int(sumValues) > finalValue2  ? true : false
        let isActive4 = Int(sumValues) < finalValue4 && Int(sumValues) > finalValue3  ? true : false
        let isActive5 = Int(sumValues) < finalValue5 && Int(sumValues) > finalValue4  ? true : false
  
        
        challengesList.append((id: 0, imageName: "Chair", imageSize: CGSize(width: width / 2, height: width / 1.4), titleName: "Hours of activity", currentValue: Int(sumValues), finalValue: finalValue1, isActive: isActive1, percent: percent1))
        challengesList.append((id: 1, imageName: "Tent", imageSize: CGSize(width: width / 1.2, height: width / 2), titleName: "Hours of activity", currentValue: Int(sumValues), finalValue: finalValue2, isActive: isActive2, percent: percent2))
        challengesList.append((id: 2, imageName: "Cover", imageSize: CGSize(width: width / 3.6, height: width / 1.5), titleName: "Hours of activity", currentValue: Int(sumValues), finalValue: finalValue3, isActive: isActive3, percent: percent3))
        challengesList.append((id: 3, imageName: "Heater", imageSize: CGSize(width: width / 1.7, height: width / 1.7), titleName: "Hours of activity", currentValue: Int(sumValues), finalValue: finalValue4, isActive: isActive4, percent: percent4))
        challengesList.append((id: 4, imageName: "SleepingBag", imageSize: CGSize(width: width / 2.5, height: width / 1.4), titleName: "Hours of activity", currentValue: Int(sumValues), finalValue: finalValue5, isActive: isActive5, percent: percent5))
    }
    
    private func calculateRestTimeChallenge(_ values: [Double]) {
        
        var sumValues: Double = values.reduce(0, {$0 + $1})
        
        sumValues = sumValues / 3600
        
        let finalValue1 = 15
        let finalValue2 = 30
        let finalValue3 = 60
        let finalValue4 = 120
        let finalValue5 = 240
        
        let percent1: CGFloat = CGFloat((Double(sumValues) / (Double(finalValue1) / 100)) / 100)
        let percent2: CGFloat = CGFloat((Double(Int(sumValues) - finalValue1) / (Double(finalValue2 - finalValue1) / 100)) / 100)
        let percent3: CGFloat = CGFloat((Double(Int(sumValues) - finalValue2) / (Double(finalValue3 - finalValue2) / 100)) / 100)
        let percent4: CGFloat = CGFloat((Double(Int(sumValues) - finalValue3) / (Double(finalValue4 - finalValue3) / 100)) / 100)
        let percent5: CGFloat = CGFloat((Double(Int(sumValues) - finalValue4) / (Double(finalValue5 - finalValue4) / 100)) / 100)
        
        let isActive1 = Int(sumValues) < finalValue1  ? true : false
        let isActive2 = Int(sumValues) < finalValue2 && Int(sumValues) > finalValue1  ? true : false
        let isActive3 = Int(sumValues) < finalValue3 && Int(sumValues) > finalValue2  ? true : false
        let isActive4 = Int(sumValues) < finalValue4 && Int(sumValues) > finalValue3  ? true : false
        let isActive5 = Int(sumValues) < finalValue5 && Int(sumValues) > finalValue4  ? true : false
        
        challengesList.append((id: 0, imageName: "Bonfire", imageSize: CGSize(width: width / 2, height: width / 1.3), titleName: "Hours of rest", currentValue: Int(sumValues), finalValue: finalValue1, isActive: isActive1, percent: percent1))
        challengesList.append((id: 1, imageName: "BowlerHat", imageSize: CGSize(width: width / 1.8, height: width / 1.5), titleName: "Hours of rest", currentValue: Int(sumValues), finalValue: finalValue2, isActive: isActive2, percent: percent2))
        challengesList.append((id: 2, imageName: "Cup", imageSize: CGSize(width: width / 3, height: width / 1.7), titleName: "Hours of rest", currentValue: Int(sumValues), finalValue: finalValue3, isActive: isActive3, percent: percent3))
        challengesList.append((id: 3, imageName: "Soup", imageSize: CGSize(width: width / 1.3, height: width / 1.7), titleName: "Hours of rest", currentValue: Int(sumValues), finalValue: finalValue4, isActive: isActive4, percent: percent4))
        challengesList.append((id: 4, imageName: "Thermos", imageSize: CGSize(width: width / 3, height: width / 1.4), titleName: "Hours of rest", currentValue: Int(sumValues), finalValue: finalValue5, isActive: isActive5, percent: percent5))
    }
    
    private func calculateClimbsTimeChallenge(_ values: [Double]) {
        
        var sumValues: Double = values.reduce(0, {$0 + $1})
        
        sumValues = sumValues / 3600
        
        let finalValue1 = 50
        let finalValue2 = 100
        let finalValue3 = 200
        let finalValue4 = 300
        let finalValue5 = 500
        
        let percent1: CGFloat = CGFloat((Double(sumValues) / (Double(finalValue1) / 100)) / 100)
        let percent2: CGFloat = CGFloat((Double(Int(sumValues) - finalValue1) / (Double(finalValue2 - finalValue1) / 100)) / 100)
        let percent3: CGFloat = CGFloat((Double(Int(sumValues) - finalValue2) / (Double(finalValue3 - finalValue2) / 100)) / 100)
        let percent4: CGFloat = CGFloat((Double(Int(sumValues) - finalValue3) / (Double(finalValue4 - finalValue3) / 100)) / 100)
        let percent5: CGFloat = CGFloat((Double(Int(sumValues) - finalValue4) / (Double(finalValue5 - finalValue4) / 100)) / 100)
        
        let isActive1 = Int(sumValues) < finalValue1  ? true : false
        let isActive2 = Int(sumValues) < finalValue2 && Int(sumValues) > finalValue1  ? true : false
        let isActive3 = Int(sumValues) < finalValue3 && Int(sumValues) > finalValue2  ? true : false
        let isActive4 = Int(sumValues) < finalValue4 && Int(sumValues) > finalValue3  ? true : false
        let isActive5 = Int(sumValues) < finalValue5 && Int(sumValues) > finalValue4  ? true : false
        
        challengesList.append((id: 0, imageName: "Buffalo", imageSize: CGSize(width: width / 1.4, height: width / 1.7), titleName: "Rise hours", currentValue: Int(sumValues), finalValue: finalValue1, isActive: isActive1, percent: percent1))
        challengesList.append((id: 1, imageName: "Deer", imageSize: CGSize(width: width / 1.8, height: width / 1.5), titleName: "Rise hours", currentValue: Int(sumValues), finalValue: finalValue2, isActive: isActive2, percent: percent2))
        challengesList.append((id: 2, imageName: "Eagle", imageSize: CGSize(width: width / 2, height: width / 1.5), titleName: "Rise hours", currentValue: Int(sumValues), finalValue: finalValue3, isActive: isActive3, percent: percent3))
        challengesList.append((id: 3, imageName: "Wolf", imageSize: CGSize(width: width / 1.5, height: width / 1.8), titleName: "Rise hours", currentValue: Int(sumValues), finalValue: finalValue4, isActive: isActive4, percent: percent4))
        challengesList.append((id: 4, imageName: "Capybara", imageSize: CGSize(width: width / 1.5, height: width / 1.8), titleName: "Rise hours", currentValue: Int(sumValues), finalValue: finalValue5, isActive: isActive5, percent: percent5))
    }
    
    private func calculateQualityChallenge(_ values: [Double]) {
        
        let finalValue = 100
        
        var qualityCount1 = 0
        var qualityCount2 = 0
        var qualityCount3 = 0
        var qualityCount4 = 0
        var qualityCount5 = 0
        
        values.forEach { (value) in
            if value >= 70 {
                qualityCount1 += 1
            }
            
            if value >= 80 {
                qualityCount2 += 1
            }
            
            if value >= 90 {
                qualityCount3 += 1
            }
            if value >= 95 {
                qualityCount4 += 1
            }
            
            if value == 100 {
                qualityCount5 += 1
            }
            
        }
        
        let percent1: CGFloat = CGFloat((Double(qualityCount1) / (Double(finalValue) / 100)) / 100)
        let percent2: CGFloat = CGFloat((Double(qualityCount2) / (Double(finalValue) / 100)) / 100)
        let percent3: CGFloat = CGFloat((Double(qualityCount3) / (Double(finalValue) / 100)) / 100)
        let percent4: CGFloat = CGFloat((Double(qualityCount4) / (Double(finalValue) / 100)) / 100)
        let percent5: CGFloat = CGFloat((Double(qualityCount5) / (Double(finalValue) / 100)) / 100)
        
        challengesList.append((id: 0, imageName: "Icebreaker", imageSize: CGSize(width: width / 2.5, height: width / 1.5), titleName: "Quality over 70", currentValue: qualityCount1, finalValue: finalValue, isActive: true, percent: percent1))
        challengesList.append((id: 1, imageName: "Lantern", imageSize: CGSize(width: width / 1.5, height: width / 1.7), titleName: "Quality over 80", currentValue: qualityCount2, finalValue: finalValue, isActive: true, percent: percent2))
        challengesList.append((id: 2, imageName: "MountainSticks", imageSize: CGSize(width: width / 1.6, height: width / 1.3), titleName: "Quality over 90", currentValue: qualityCount3, finalValue: finalValue, isActive: true, percent: percent3))
        challengesList.append((id: 3, imageName: "Rope", imageSize: CGSize(width: width / 1.5, height: width / 1.5), titleName: "Quality over 95", currentValue: qualityCount4, finalValue: finalValue, isActive: true, percent: percent4))
        challengesList.append((id: 4, imageName: "Pegs", imageSize: CGSize(width: width / 2.5, height: width / 1.7), titleName: "Quality is 100", currentValue: qualityCount5, finalValue: finalValue, isActive: true, percent: percent5))
    }
    
}
