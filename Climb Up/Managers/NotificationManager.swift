//
//  NotificationManager.swift
//  Climb Up
//
//  Created by Bohdan on 13.12.2020.
//

import SwiftUI

class NotificationCenterManager: NSObject {

    private let notificationCenter = UNUserNotificationCenter.current()
    var notificationActionDelegate: NotificationActionDelegate?
    
    override init() {
        super.init()
        notificationCenter.delegate = self
        
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (allowed, error) in
            if allowed {
                print("Allowed")
            } else {
                print("Error")
            }
        }
    }
    
    func setLocalNotification(title: String, subtitle: String, body: String, when: Double, notificationType: NotificationType) {
        
        let content = UNMutableNotificationContent()
        let categoryIdentifire = notificationType.rawValue
        
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = categoryIdentifire
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: when, repeats: false)
        let identifier = "Local Notification \(Date() + when)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        switch notificationType {
        case .DoubleInterval :
            let SkipInterval = UNNotificationAction(identifier: NotificationActionBtn.SkipInterval.rawValue, title: "Next interval", options: [])
            let EndTimer = UNNotificationAction(identifier: NotificationActionBtn.EndTimer.rawValue, title: "Finish", options: [])
            let category = UNNotificationCategory(identifier: categoryIdentifire,
                                                  actions: [SkipInterval, EndTimer],
                                                  intentIdentifiers: [],
                                                  options: [])
            
            notificationCenter.setNotificationCategories([category])
            
        case .Interval :
            let SwitchState = UNNotificationAction(identifier: NotificationActionBtn.IntervalSwitch.rawValue, title: "Toggle state", options: [])
            let EndTimer = UNNotificationAction(identifier: NotificationActionBtn.EndTimer.rawValue, title: "Finish", options: [])
            let category = UNNotificationCategory(identifier: categoryIdentifire,
                                                  actions: [SwitchState, EndTimer],
                                                  intentIdentifiers: [],
                                                  options: [])
            
            notificationCenter.setNotificationCategories([category])
            
        case .EndTimer :
            let Quality60 = UNNotificationAction(identifier: NotificationActionBtn.Quality60.rawValue, title: "Quality 60%", options: [])
            let Quality70 = UNNotificationAction(identifier: NotificationActionBtn.Quality70.rawValue, title: "Quality 70%", options: [])
            let Quality80 = UNNotificationAction(identifier: NotificationActionBtn.Quality80.rawValue, title: "Quality 80%", options: [])
            let Quality90 = UNNotificationAction(identifier: NotificationActionBtn.Quality90.rawValue, title: "Quality 90%", options: [])
            let Quality95 = UNNotificationAction(identifier: NotificationActionBtn.Quality95.rawValue, title: "Quality 95%", options: [])
            let Quality100 = UNNotificationAction(identifier: NotificationActionBtn.Quality100.rawValue, title: "Quality 100%", options: [])
            let category = UNNotificationCategory(identifier: categoryIdentifire,
                                                  actions: [Quality60, Quality70, Quality80, Quality90, Quality95, Quality100],
                                                  intentIdentifiers: [],
                                                  options: [])
            
            notificationCenter.setNotificationCategories([category])
        default :
            print("None")
        }
  
    }
    
    func removeAllNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.removeAllDeliveredNotifications()
    }
}

extension NotificationCenterManager: UNUserNotificationCenterDelegate  {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        DispatchQueue.main.async { [weak self] in
            self?.notificationActionDelegate?.notificationBtnPress(btnId: NotificationActionBtn.init(rawValue: response.actionIdentifier) ?? .None)
        }
        
        completionHandler()
    }
}

// MARK: - Notification delegate
protocol NotificationActionDelegate {
    func notificationBtnPress(btnId: NotificationActionBtn)
}
