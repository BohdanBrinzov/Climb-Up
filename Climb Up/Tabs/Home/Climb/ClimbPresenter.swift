//
//  ClimbPresenter.swift
//  Climb Up
//
//  Created by Bohdan on 12.12.2020.
//

import SwiftUI

class ClimbPresenter: ObservableObject {
    
    typealias DateIntervalWithType = (index: Int, startDate: Date, endDate: Date, isActive: Bool)
    typealias LapsFinishList = (id: Int, color: Color, interval: Double, startDate: Date, endDate: Date)
    
    private let interactor = ClimbInteractor()
    
    // MARK: Notificztion manager
    private var notificationManager = NotificationCenterManager()
    
    // MARK: Progress bar vars
    @Published var currentProgress: Double = 0
    @Published var currentColor = Color.mainOrange
    
    // MARK: Notificarions arr
    var timeNotificationArr: [DateIntervalWithType] = []
    var startClimbDate = Date()
    @Published var finishedLaps: [(id: Int, color: Color, interval: Double, startDate: Date, endDate: Date)] = []
    
    // MARK: Interface values
    @Published var currentTimeTimer: Double = 0
    @Published var totalTime: Double = 0
    @Published var activeTime: Double = 0
    @Published var restTime: Double = 0
    
    @Published var lapsRemaining = 0
    
    
    // MARK: Current Aspiration
    var currentAcpiration: Aspiration!
    var interval: Double?
    
    // MARK: Interface state
    @Published var isEndClimb = false
    
    
    // MARK: Init private consts
    private let lapsStepper: Int
    private let intervalStepper: Int
    private let restStepper: Int
    private let activeStapper: Int
    private let onlyTimeStepper: Int
    
    let currentDraggingState: DraggingInterfaceState
    
    // MARK: NotificationCenter observer
    let notificationCenter = NotificationCenter.default
    
    
    // MARK: - Init
    init(lapsStepper: Int, intervalStepper: Int, activeStapper: Int, restStepper: Int, onlyTimeStepper: Int, draggingState: DraggingInterfaceState, currentAcpiration: Aspiration? = nil) {
        
        self.lapsStepper = lapsStepper
        self.intervalStepper = intervalStepper * 60
        self.activeStapper = activeStapper * 60
        self.restStepper = restStepper * 60
        self.onlyTimeStepper = onlyTimeStepper
        self.currentDraggingState = draggingState
        self.startClimbDate = Date()
        self.currentAcpiration = currentAcpiration
        
        notificationManager.notificationActionDelegate = self
        
        switch draggingState {
        case .left:
            self.interval = Double(intervalStepper * 60)
            self.generateIntervalNotifications(laps: lapsStepper, interval: intervalStepper * 60)
        case .center:
            self.generateDoubleIntervalNotifications(active: activeStapper * 60, rest: restStepper * 60)
        case .right:
            self.generateTimeNotifications(timeStepper: onlyTimeStepper)
        default:
            print("")
        }
        
        // MARK: Notification center
        self.addObservers()
    }
    
    ///Generate notifications
    // MARK: Init functions
    func generateIntervalNotifications(laps: Int, interval: Int) {
        
        var timeNotificationArr: [DateIntervalWithType] = []
        
        for index in 0...laps {
            
            var startDate: Date = Date()
            
            if index > 0 {
                startDate = Date() + TimeInterval((interval * (index - 1)))
            }
            
            let endDate: Date = Date() + TimeInterval((interval * index))
            
            let intervalDates = (index: index, startDate: startDate, endDate: endDate, isActive: true)
            
            timeNotificationArr.append(intervalDates)
            
        }
        
        self.timeNotificationArr = timeNotificationArr
    }
    
    func generateDoubleIntervalNotifications(active: Int, rest: Int) {
        
        
        for index in 0...60 {
            
            if index % 2 == 0 {
                
                var startDateActive: Date = startClimbDate
                var endDateActive: Date = startClimbDate
                
                if timeNotificationArr.last != nil {
                    startDateActive = timeNotificationArr.last!.endDate
                } else {
                    startDateActive = startClimbDate
                }
                
                if  timeNotificationArr.last != nil {
                    endDateActive = timeNotificationArr.last!.endDate + TimeInterval(active)
                } else {
                    endDateActive = startClimbDate + TimeInterval((active))
                }
                
                let activeNotification = (index: index, startDate: startDateActive, endDate: endDateActive, isActive: true)
                
                timeNotificationArr.append(activeNotification)
                
            } else {
                
                let startDateRest: Date = timeNotificationArr.last!.endDate
                
                let endDateRest: Date = timeNotificationArr.last!.endDate + TimeInterval(rest)
                
                let restNotification = (index: index, startDate: startDateRest, endDate: endDateRest, isActive: false)
                
                timeNotificationArr.append(restNotification)
            }
            
            
        }
        
        let lastIndex = timeNotificationArr.count - 1
        
        timeNotificationArr.remove(at: lastIndex)
    }
    
    func generateTimeNotifications(timeStepper: Int) {
        
        var timeNotificationArr: [DateIntervalWithType] = []
        
        let startDate: Date = Date()
        
        let endDate: Date = Date() + TimeInterval((timeStepper * 5 * 60))
        
        let intervalDates = (index: 0, startDate: startDate, endDate: endDate, isActive: true)
        
        timeNotificationArr.append(intervalDates)

        self.timeNotificationArr = timeNotificationArr

    }
}

// MARK: - Update interface
extension ClimbPresenter {
    
    func updateInterface() -> Bool {
        
        let arr = self.timeNotificationArr
        
        let item = arr.filter { (index, startDate, endDate, isActive) -> Bool in
            
            return  abs(startDate.timeIntervalSince1970) <= abs(Date().timeIntervalSince1970)  && abs(endDate.timeIntervalSince1970)  >= abs(Date().timeIntervalSince1970)
        }
        
        guard let currentItem = item.first else {
            DispatchQueue.main.async {
                
                let (totalTime, activeTime, restTime) = self.getFinishValues()
                self.totalTime = totalTime
                self.activeTime = activeTime
                self.restTime = restTime
                
                self.isEndClimb = true
            }
            return true
        }
        guard let lastItem = arr.last else { return true }
        

            let previousItem = timeNotificationArr.filter { (index, startDate, endDate, isActive) -> Bool in
                // MARK: MDAAAAAAAAAAA IIIO 3A IF
                if currentDraggingState == .left {
                    return endDate <= currentItem.startDate && index != 0
                } else {
                    return endDate <= currentItem.startDate
                }
            }
        finishedLaps = previousItem.compactMap({ (index, startDate, endDate, isActive) -> LapsFinishList in
                return (id: index, color: isActive ? Color.mainOrange : Color.mainBlue, interval:  endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970, startDate: startDate, endDate: endDate)
            })
        
        var totalTime = 0.0
        var activityTime = 0.0
        var restTime = 0.0
        
        var lapsRemaining = 0
        
        var currentInterval = 0.0
        var currentPercent: CGFloat = 0.0
        var currentColor: Color = .gray
        
        lapsRemaining = arr.count - currentItem.index
        
        totalTime = abs(startClimbDate.timeIntervalSince1970 - Date().timeIntervalSince1970)
        currentInterval =  abs(currentItem.endDate.timeIntervalSince1970 - currentItem.startDate.timeIntervalSince1970) - abs(currentItem.startDate.timeIntervalSince1970 - Date().timeIntervalSince1970)
        
        currentColor = currentItem.isActive ? Color.mainOrange : Color.mainBlue
        
        if currentDraggingState != .right {
            currentPercent = CGFloat((abs(Date().timeIntervalSince1970 - currentItem.startDate.timeIntervalSince1970) / (abs(currentItem.endDate.timeIntervalSince1970 - currentItem.startDate.timeIntervalSince1970) / 100)) / 100)
        } else {
            currentPercent = CGFloat((abs(Date().timeIntervalSince1970 - startClimbDate.timeIntervalSince1970) / (abs(currentItem.endDate.timeIntervalSince1970 - startClimbDate.timeIntervalSince1970) / 100)) / 100)
        }
        
        for index in 0...currentItem.index{
            
            if index != currentItem.index {
                if arr[index].isActive {
                    activityTime += abs(arr[index].startDate.timeIntervalSince1970 -  arr[index].endDate.timeIntervalSince1970)
                } else {
                    restTime += abs(arr[index].startDate.timeIntervalSince1970 -  arr[index].endDate.timeIntervalSince1970)
                }
            } else {
                if arr[index].isActive {
                    activityTime += abs(arr[index].startDate.timeIntervalSince1970 -  Date().timeIntervalSince1970)
                } else {
                    restTime += abs(arr[index].startDate.timeIntervalSince1970 -  Date().timeIntervalSince1970)
                }
            }
            
        }
        

        
        if abs(lastItem.endDate.timeIntervalSince1970) >= abs(Date().timeIntervalSince1970) {
            DispatchQueue.main.async {
                self.currentTimeTimer = currentInterval + 1
                self.totalTime = totalTime
                self.activeTime = activityTime
                self.restTime = restTime
                self.lapsRemaining = lapsRemaining - 1
                
                self.currentProgress = Double(currentPercent * 100)
                self.currentColor = currentColor
            }
        } else {
            DispatchQueue.main.async {
                
                let (totalTime, activeTime, restTime) = self.getFinishValues()
                self.totalTime = totalTime
                self.activeTime = activeTime
                self.restTime = restTime
                
                self.isEndClimb = true
            }
        }
        
        return false
    }
}

// MARK: - Generate notifications
extension ClimbPresenter {
    
    func generateNotifications() {
        
        if currentDraggingState == .center {
            
            let arr = timeNotificationArr.filter { (index, startDate, endDate, isActive) -> Bool in
                endDate.timeIntervalSince1970 > Date().timeIntervalSince1970
            }
            
//            if let first = arr.first {
//                notificationManager.setLocalNotification(title: first.isActive ? "Active interval started" : "Rest interval started", subtitle: "" , body: "" , when: 2, notificationType: .None)
//            }
            
            arr.forEach { index, startDate, endDate, isActive in
                
                let title = isActive ? "Rest interval started" : "Active interval started"
                let subtitle = "Total time: \(abs(endDate.timeIntervalSince1970 - startClimbDate.timeIntervalSince1970).asDateString(style: .abbreviated))"
                let body = isActive ? " + Active time: \((endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970 ).asDateString(style: .abbreviated))" : " + Rest time: \((endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970).asDateString(style: .abbreviated))"
                
               
                if index != timeNotificationArr.count - 1 {
                    self.notificationManager.setLocalNotification(title: title,
                                                                   subtitle: subtitle,
                                                                   body: body,
                                                                   when: abs(endDate.timeIntervalSince1970 - Date().timeIntervalSince1970),
                                                                   notificationType: .DoubleInterval)

                } else {
                    self.notificationManager.setLocalNotification(title: "Climb is Finished",
                                                                  subtitle: "",
                                                                  body: "Set the quality to save",
                                                                  when: abs(endDate.timeIntervalSince(Date())),
                                                                  notificationType: .None)
                }
                
                
            }
        } else if currentDraggingState == .left {
            
            let arr = timeNotificationArr.filter { (index, startDate, endDate, isActive) -> Bool in
                endDate.timeIntervalSince1970 > Date().timeIntervalSince1970
            }
            
//            if let first = arr.first {
//                notificationManager.setLocalNotification(title: first.isActive ? "Switched to Active" : "Switched to Rest", subtitle: "" , body: "" , when: 2, notificationType: .None)
//            }
            
            arr.forEach { index, startDate, endDate, isActive in
                
                
                let title = isActive ? "Climb state: Active" : "Climb state: Rest"
                let subtitle = "Laps remaining \(timeNotificationArr.count - index - 1)"
                let body = "Total time: \((endDate.timeIntervalSince1970 - startClimbDate.timeIntervalSince1970).asDateString(style: .abbreviated))"
                
                
                
                if index != timeNotificationArr.count - 1 {
                    self.notificationManager.setLocalNotification(title: title,
                                                                 subtitle: subtitle,
                                                                 body: body,
                                                                 when: abs(endDate.timeIntervalSince1970 - Date().timeIntervalSince1970),
                                                                 notificationType: .Interval)

                } else {
                    self.notificationManager.setLocalNotification(title: "Climb is Finished",
                                                                  subtitle: "Total time: \((endDate.timeIntervalSince1970 - startClimbDate.timeIntervalSince1970).asDateString(style: .abbreviated))",
                                                                  body: "Set the quality to save",
                                                                  when: abs(endDate.timeIntervalSince(Date())),
                                                                  notificationType: .None)
                }
                
                
            }
            
        } else if currentDraggingState == .right {
            
            let arr = timeNotificationArr.filter { (index, startDate, endDate, isActive) -> Bool in
                endDate.timeIntervalSince1970 > Date().timeIntervalSince1970
            }
            
           if let last = arr.last {
                
                let title = "Climb is Finished"
            let subtitle = "Total time: \((last.endDate.timeIntervalSince1970 - startClimbDate.timeIntervalSince1970).asDateString(style: .abbreviated))"
                let body = "Set the quality to save"
                
                notificationManager.setLocalNotification(title: title,
                                                         subtitle: subtitle,
                                                         body: body,
                                                         when: abs(last.endDate.timeIntervalSince1970 - Date().timeIntervalSince1970),
                                                         notificationType: .None)
                
                
            }
        }
    }
    
    func generateNotificationsInBackground() {
        self.notificationManager.removeAllNotifications()
        self.generateNotifications()
    }
}

// MARK: - NotificationActionDelegate
extension ClimbPresenter: NotificationActionDelegate {
    
    func notificationBtnPress(btnId: NotificationActionBtn) {
        
        switch btnId {
        case .IntervalSwitch:
            self.nextIntervalInBackground()
        case .SkipInterval:
            self.nextIntervalInBackground()
        case .EndTimer:
            self.stopTimer()
        case .Quality100:
            self.endClimbWithSaveInNotification(endQuality: btnId)
        case .Quality95:
            self.endClimbWithSaveInNotification(endQuality: btnId)
        case .Quality90:
            self.endClimbWithSaveInNotification(endQuality: btnId)
        case .Quality80:
            self.endClimbWithSaveInNotification(endQuality: btnId)
        case .Quality70:
            self.endClimbWithSaveInNotification(endQuality: btnId)
        case .Quality60:
            self.endClimbWithSaveInNotification(endQuality: btnId)
        case .None:
            print("None")
        }
    }
}

// MARK: - Finish climb funcs
extension ClimbPresenter {
    
    func endClimbWithSaveInNotification(endQuality: NotificationActionBtn) {
        
        var finalQuality = 0
        
        let (totalTime, activeTime, restTime) = self.getFinishValues()
        self.totalTime = totalTime
        self.activeTime = activeTime
        self.restTime = restTime
        
        switch endQuality {
        case .Quality100:
            finalQuality = 100
        case .Quality95:
            finalQuality = 95
        case .Quality90:
            finalQuality = 90
        case .Quality80:
            finalQuality = 80
        case .Quality70:
            finalQuality = 70
        case .Quality60:
            finalQuality = 60
        default:
            print("NotificationActionBtn is undefined")
        }
        
        if currentAcpiration == nil {
            if let aspInteractor = interactor.getAspiration(byName: "\(Date().getFormattedDate(format: "MMM , yyyy"))") {
                currentAcpiration = aspInteractor
            } else {
                currentAcpiration = Aspiration(name: "\(Date().getFormattedDate(format: "MMM , yyyy"))", color: .gray, date: Date())
                interactor.addAspiration(aspiration: currentAcpiration)
            }
        }
        
        let climb = Climb(date: Date(), quality: Int16(finalQuality), timeAll: totalTime, timeActive: activeTime, timeRest: restTime, timeInterval: interval, aspiration: currentAcpiration)
        
        interactor.addClimb(toAspiration: currentAcpiration, climb: climb)
        
        notificationManager.removeAllNotifications()
        removeObservers()
        
        notificationManager.setLocalNotification(title: "Climb added successfully", subtitle: "", body: "", when: 1, notificationType: .None)
        
    }
    
    
    func saveClimb(pickerValue: Int) {
        
        let (totalTime, activeTime, restTime) = self.getFinishValues()
        self.totalTime = totalTime
        self.activeTime = activeTime
        self.restTime = restTime
        
        let isClimbFinish = self.updateInterface()
        let quality = Int16((-pickerValue + 20) * 5)
        
        if isClimbFinish {
            
            if currentAcpiration == nil {
                if let aspInteractor = interactor.getAspiration(byName: "\(Date().getFormattedDate(format: "MMM , yyyy"))") {
                    currentAcpiration = aspInteractor
                } else {
                    currentAcpiration = Aspiration(name: "\(Date().getFormattedDate(format: "MMM , yyyy"))", color: .gray, date: Date())
                    interactor.addAspiration(aspiration: currentAcpiration)
                }
            }
    
            let climb = Climb(date: Date(), quality: quality, timeAll: totalTime, timeActive: activeTime, timeRest: restTime, timeInterval: interval, aspiration: currentAcpiration)
    
            interactor.addClimb(toAspiration: currentAcpiration, climb: climb)
    
            notificationManager.removeAllNotifications()
            removeObservers()
            
            DispatchQueue.main.async {
                self.isEndClimb = true
            }
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

// MARK: - Work with observer + Notificacion user by app state
extension ClimbPresenter {

    func addObservers() {
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
    }

    func removeObservers() {
        notificationCenter.removeObserver(self)
        notificationManager.removeAllNotifications()
    }
    
    @objc func appWillTerminate() {
        notificationCenter.removeObserver(self)
        notificationManager.removeAllNotifications()
    }
    
    @objc func appMovedToActive() {
        notificationManager.removeAllNotifications()
    }

    @objc func appMovedToBackground() {
        if isEndClimb != true {
            generateNotifications()
        }
    }
}

// MARK: - Work with timer
extension ClimbPresenter {
    
    func nextInterval() {
        var arr: [DateIntervalWithType] = []
        
        if currentDraggingState == .center {
            
            for interval in timeNotificationArr {
                
                if Date().timeIntervalSince1970 < interval.endDate.timeIntervalSince1970 && interval.startDate.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                    
                    let intervalDates = (index: interval.index, startDate: interval.startDate, endDate: Date(), isActive: interval.isActive)
                    
                    finishedLaps.append( LapsFinishList(id: intervalDates.index, color: interval.isActive ? Color.mainOrange : Color.mainBlue, interval: intervalDates.endDate.timeIntervalSince1970 - intervalDates.startDate.timeIntervalSince1970, startDate: intervalDates.startDate, endDate: intervalDates.endDate))
                    
                    arr.append(intervalDates)
                    
                    break
                }
                
                let intervalDates = (index: interval.index, startDate: interval.startDate, endDate: interval.endDate, isActive: interval.isActive)
                
                arr.append(intervalDates)
            }
            

            let countRemainingIntervals = (timeNotificationArr.count) + 1
            guard let lastInterval = arr.last else { return }
            let nextIndex = lastInterval.index + 1
            
            for index in nextIndex...countRemainingIntervals {
                
                if !arr.last!.isActive {
                    
                    var startDateActive: Date = startClimbDate
                    var endDateActive: Date = startClimbDate
                    
                    if arr.last != nil {
                        startDateActive = arr.last!.endDate
                    } else {
                        startDateActive = startClimbDate
                    }
                    
                    if  arr.last != nil {
                        endDateActive = arr.last!.endDate + TimeInterval(activeStapper)
                    } else {
                        endDateActive = startClimbDate + TimeInterval((activeStapper))
                    }
                    
                    let activeNotification = (index: index, startDate: startDateActive, endDate: endDateActive, isActive: true)
                    
                    arr.append(activeNotification)
                    
                } else {
                    
                    let startDateRest: Date = arr.last!.endDate
                    
                    let endDateRest: Date = arr.last!.endDate + TimeInterval(restStepper)
                    
                    let restNotification = (index: index, startDate: startDateRest, endDate: endDateRest, isActive: false)
                    
                    arr.append(restNotification)
                }
            }
        } else if currentDraggingState == .left {
            
            for interval in timeNotificationArr {
                
                if Date().timeIntervalSince1970 < interval.endDate.timeIntervalSince1970 && interval.startDate.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                    
                    // MARK: finished laps
                    let intervalDates = (index: interval.index, startDate: interval.startDate, endDate: Date(), isActive: interval.isActive)
                    
                    finishedLaps.append( LapsFinishList(id: interval.index, color: interval.isActive ? Color.mainOrange : Color.mainBlue, interval: Date().timeIntervalSince1970 - interval.startDate.timeIntervalSince1970, startDate: interval.startDate, endDate: interval.endDate))
                    
                    arr.append(intervalDates)
                    
                    break
                }
                
                let intervalDates = (index: interval.index, startDate: interval.startDate, endDate: interval.endDate, isActive: interval.isActive)
                
                arr.append(intervalDates)
            }
            

            
            let countRemainingIntervals = timeNotificationArr.count 
            guard let lastInterval = arr.last else { return }
            let nextIndex = lastInterval.index + 1
            
            
            for index in nextIndex...countRemainingIntervals {
                
                var startDateActive: Date = startClimbDate
                var endDateActive: Date = startClimbDate
                
                if arr.last != nil {
                    startDateActive = arr.last!.endDate
                } else {
                    startDateActive = startClimbDate
                }
                
                if  arr.last != nil {
                    endDateActive = arr.last!.endDate + TimeInterval(intervalStepper)
                } else {
                    endDateActive = startClimbDate + TimeInterval((intervalStepper))
                }
                
                let activeNotification = (index: index, startDate: startDateActive, endDate: endDateActive, isActive: !lastInterval.isActive)
                
                arr.append(activeNotification)
                
            }
        } else if currentDraggingState == .right {
            
            for interval in timeNotificationArr {
                
                if Date().timeIntervalSince1970 < interval.endDate.timeIntervalSince1970 && interval.startDate.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                    
                    let intervalDates = (index: interval.index, startDate: interval.startDate, endDate: Date(), isActive: interval.isActive)
                    
                    arr.append(intervalDates)
                    
                    finishedLaps.append( LapsFinishList(id: interval.index, color: interval.isActive ? Color.mainOrange : Color.mainBlue, interval: Date().timeIntervalSince1970 - interval.startDate.timeIntervalSince1970, startDate: interval.startDate, endDate: interval.endDate))
                    
                    let intervalDatesNext = (index: interval.index + 1, startDate: intervalDates.endDate, endDate: interval.endDate, isActive: !interval.isActive)
                    
                    arr.append(intervalDatesNext)

                    
                    break
                }
                
                let intervalDates = (index: interval.index, startDate: interval.startDate, endDate: interval.endDate, isActive: interval.isActive)
                
                arr.append(intervalDates)
            }
        }
        
        self.timeNotificationArr = arr
        
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.5)
    }
    
    func nextIntervalInBackground() {
        nextInterval()
        generateNotificationsInBackground()
    }
    
    func stopTimer() {
        
        var arr: [DateIntervalWithType] = []
        
        for interval in timeNotificationArr {
            
            if Date().timeIntervalSince1970 < interval.endDate.timeIntervalSince1970 && interval.startDate.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                let intervalDates = (index: interval.index, startDate: interval.startDate, endDate: Date(), isActive: interval.isActive)
                
                arr.append(intervalDates)
                
                break
            }
            
            let intervalDates = (index: interval.index, startDate: interval.startDate, endDate: interval.endDate, isActive: interval.isActive)
            
            arr.append(intervalDates)
        }
        
        
        self.timeNotificationArr = arr
        
        let (totalTime, activeTime, restTime) = self.getFinishValues()
        self.totalTime = totalTime
        self.activeTime = activeTime
        self.restTime = restTime
        
        ///Notifications
        notificationManager.removeAllNotifications()
        
        notificationManager.setLocalNotification(title: "Climb is Finish", subtitle: "Set quality for completion" , body: "Total time: " + totalTime.asDateString(style: .short) + ", Activity time: " + activeTime.asDateString(style: .short) + ", Rest time: " + restTime.asDateString(style: .short), when: 2, notificationType: .None)
        
        ///State interface
        DispatchQueue.main.async {
            self.isEndClimb = true
        }
    }
}

// MARK: - Get finish values
extension ClimbPresenter {
    
    func getFinishValues() -> (Double, Double, Double) {
            
        let arr = self.timeNotificationArr
            
        guard let lastItem = arr.last else { return (0, 0, 0) }
        
        var totalTime = 0.0
        var activityTime = 0.0
        var restTime = 0.0
        
        totalTime = abs(startClimbDate.timeIntervalSince1970 - lastItem.endDate.timeIntervalSince1970)
    
        for index in 0...arr.count - 1{
        
            if arr[index].isActive {
                activityTime += abs(arr[index].startDate.timeIntervalSince1970 -  arr[index].endDate.timeIntervalSince1970)
            } else {
                restTime += abs(arr[index].startDate.timeIntervalSince1970 -  arr[index].endDate.timeIntervalSince1970)
            }
        }
            
        return (totalTime, activityTime, restTime)
    }
}
