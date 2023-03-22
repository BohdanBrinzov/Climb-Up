//
//  ChartPresenter.swift
//  Climb Up
//
//  Created by Bohdan on 20.11.2020.
//

import SwiftUI
import Combine

class ChartPresenter: ObservableObject {
    
    
    private let interactor: ChartInteractor
    private let router = ChartRouter()
    
    // MARK: - Climbs
    @Published var climbs: [Climb] = []
    @Published var filteredClimbsByCurrentMonth: [Climb] = []
    
    // MARK: - Chart values
    @Published var totalValues: (totalTime: Double, totalActive: Double, totalRest: Double, averageQuality: Double) = (0, 0, 0, 0)
    @Published var totalTimeChart: [Double] = []
    @Published var totalActiveChart: [Double] = []
    @Published var totalRestChart: [Double] = []
    @Published var qualitiesChart: [Double] = []
    
    // MARK: - Private vars
    @Environment(\.calendar) var calendar
    private var year: DateInterval { calendar.dateInterval(of: .month, for: Date())! }
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(interactor: ChartInteractor) {
        self.interactor = interactor
        
        // MARK: - All climbs
        interactor.$climbs
            .assign(to: \.climbs, on: self)
            .store(in: &cancellables)
        
        // MARK: - Total
        $filteredClimbsByCurrentMonth
            .map({ item -> AspirationPresenter.TotalClimbValues in
                
                var totalTime: Double = 0
                var totalActive: Double = 0
                var totalRest: Double = 0
                var averageQuality: Double = 0
                
                let count = item.count
                
                var countZeroQualities = 0
                
                item.forEach({ (item) in
                    totalTime += item.timeAll ?? 0
                    totalActive += item.timeActive ?? 0
                    totalRest += item.timeRest ?? 0
                    
                    if item.quality ?? -1 > 0 {
                        averageQuality += Double(item.quality ?? 0)
                    } else {
                        countZeroQualities += 1
                    }
                    
                  
                })
                
                if averageQuality > 0 {
                    averageQuality = averageQuality / Double(count - countZeroQualities)
                }
                
                return (totalTime: totalTime, totalActive: totalActive, totalRest: totalRest, averageQuality: averageQuality)
            })
            .assign(to: \.totalValues, on: self)
            .store(in: &cancellables)
        
        // MARK: - Charts publishers
        
        // MARK: Total time
        $filteredClimbsByCurrentMonth
            .map({ item -> [Double] in

                var currentDayCounting: Int = 1
                var currentItemCounting: Int = 0

                var totalTime: [Double] = []

                item.forEach({ (item) in

                    if totalTime.count == 0 {
                        currentDayCounting = item.date.get(.day)
                        totalTime.append(Double(item.timeAll ?? 0))
                    } else {

                        if item.date.get(.day) == currentDayCounting {
                                totalTime[currentItemCounting] = totalTime[currentItemCounting] + Double(item.timeAll ?? 0)
                        } else {
                            currentDayCounting = item.date.get(.day)
                            currentItemCounting += 1
                            totalTime.append(Double(item.timeAll ?? 0))
                        }
                    }
                })

                return totalTime
            })
            .assign(to: \.totalTimeChart, on: self)
            .store(in: &cancellables)
        
        // MARK: Active time
        $filteredClimbsByCurrentMonth
            .map({ item -> [Double] in
                
                var currentDayCounting: Int = 1
                var currentItemCounting: Int = 0
                
                var totalActivity: [Double] = []
                
                item.forEach({ (item) in
                    
                    if totalActivity.count == 0 {
                        currentDayCounting = item.date.get(.day)
                        totalActivity.append(Double(item.timeActive ?? 0))
                    } else {
                        
                        if item.date.get(.day) == currentDayCounting {
                            totalActivity[currentItemCounting] = totalActivity[currentItemCounting] + Double(item.timeActive ?? 0)
                        } else {
                            currentDayCounting = item.date.get(.day)
                            currentItemCounting += 1
                            totalActivity.append(Double(item.timeActive ?? 0))
                        }
                    }
                })
                
                return totalActivity
            })
            .assign(to: \.totalActiveChart, on: self)
            .store(in: &cancellables)
        
        // MARK: Rest time
        $filteredClimbsByCurrentMonth
            .map({ item -> [Double] in
                
                var currentDayCounting: Int = 1
                var currentItemCounting: Int = 0
                
                var totalRest: [Double] = []
                
                item.forEach({ (item) in
                    
                    if totalRest.count == 0 {
                        currentDayCounting = item.date.get(.day)
                        totalRest.append(Double(item.timeRest ?? 0))
                    } else {
                        
                        if item.date.get(.day) == currentDayCounting {
                            totalRest[currentItemCounting] = totalRest[currentItemCounting] + Double(item.timeRest ?? 0)
                        } else {
                            currentDayCounting = item.date.get(.day)
                            currentItemCounting += 1
                            totalRest.append(Double(item.timeRest ?? 0))
                        }
                    }
                })
                
                return totalRest
            })
            .assign(to: \.totalRestChart, on: self)
            .store(in: &cancellables)
        
        // MARK: Qualities
        $filteredClimbsByCurrentMonth
            .map({ item -> [Double] in
                
                var currentDayCounting: Int = 1
                var currentItemCounting: Int = 0
                var quantityQualityPerDay = 0
                
                var qualities: [Double] = []
                
                // MARK: sort by date
                let sorteredByDate = item.sorted(by: { (climbPrevious, climbNext) -> Bool in
                    climbPrevious.date.timeIntervalSince1970 < climbNext.date.timeIntervalSince1970
                })
                
                sorteredByDate.forEach({ (item) in
                    
                    if item.quality != nil {
                    
                        if qualities.count == 0 {
                            currentDayCounting = item.date.get(.day)
                            quantityQualityPerDay = 1
                            qualities.append(Double(item.quality ?? 0))
                        } else {
                            
                            if item.date.get(.day) == currentDayCounting {
                                qualities[currentItemCounting] = qualities[currentItemCounting] + Double(item.quality ?? 0)
                                quantityQualityPerDay += 1
                            } else {
                                
                                qualities[currentItemCounting] = qualities[currentItemCounting] / Double(quantityQualityPerDay)
                               
                                currentDayCounting = item.date.get(.day)
                                
                                currentItemCounting += 1
                                quantityQualityPerDay = 1
                                qualities.append(Double(item.quality ?? 0))
                            }
                        }
                    }
                    
                })
                
                if currentItemCounting != 0 {
                    qualities[currentItemCounting] = qualities[currentItemCounting] / Double(quantityQualityPerDay)
                }
                
                
                return qualities
            })
            .assign(to: \.qualitiesChart, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Build views
    func makeCalendarView() -> some View {
        CalendarView(interval: self.year) { [unowned self] date in
            Text("30")
                .hidden()
                .padding(8)
                .clipShape(Circle())
                .cornerRadius(4)
                .padding(4)
                .overlay(
                    ZStack {
                        if self.isDateExistsInClimbs(date: date) {
                            self.linkBuilder(for: date) {
                                Circle()
                                    .foregroundColor(Color.mainAquaDarkest)
                                    .padding(4)
                            }
                        } else {
                            Circle()
                                .foregroundColor(Color.mainAquaDarkest.opacity(0.4))
                                .padding(4)
                        }
                        Text(String(self.calendar.component(.day, from: date)))
                            .foregroundColor(.white)
                    }
                )
        }
        .padding(.top, 20)
    }
    
    // MARK: - Functions
    func isDateExistsInClimbs(date: Date) -> Bool {
        
        if String(self.calendar.component(.day, from: date)) == "15" {
            // MARK: set filtered climbs by month
            DispatchQueue.main.async { [unowned self] in
                self.filteredClimbsByCurrentMonth = self.climbs.filter { climb -> Bool in
                    climb.date.isSameMonth(date)
                }.sorted(by: { (climbPrevious, climbNext) -> Bool in
                    climbPrevious.date.timeIntervalSince1970 < climbNext.date.timeIntervalSince1970
                })
            }
        }
        
        let filteredValue = climbs.filter { climb in
            climb.date.isSameDate(date)
        }.first
        
        guard let _ = filteredValue else {
            return false
        }
        
        return true
    }
    
    // MARK: - Build links
    func linkBuilder<Content: View>(for date: Date, @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeClimbsListByDateView(for: date)) {
            content()
        }
    }
    
}

