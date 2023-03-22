//
//  Climb_UpApp.swift
//  Climb Up
//
//  Created by Bohdan on 05.11.2020.
//

import SwiftUI
import Combine

@main
struct Climb_UpApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    private let coloredNavAppearance = UINavigationBarAppearance()
    
    
    @State var HomeMoule = HomeView(presenter: HomePresenter())
    @State var ChallengeMoule = ChallengesListView(presenter: ChallengesListPresenter(interactor: ChallengesListInteractor()))
    @State var ChartModule =  ChartView(presenter: ChartPresenter(interactor: ChartInteractor()))
    @State var AspirationMoule = AspirationListView(presenter: AspirationListPresenter(interactor: AspirationListInteractor()))
    

    init() {
        // FIXME: Navigation bar color
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor =  UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
        
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    
    var body: some Scene {
        WindowGroup {
            TabView {
                //MARK: - First view
                HomeMoule
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }.tag(1)
                
                //MARK: - Second view
                NavigationView {
                    ChallengeMoule
                }
                .tabItem {
                    VStack {
                        Image(systemName: "flag.fill")
                        Text("Challenges")
                    }
                }
                .tag(2)
                
                //MARK: - Third view
                NavigationView {
                    ChartModule
                }
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar.fill")
                        Text("Chart")
                    }
                }
                .tag(3)
                
                //MARK: - Forth view
                NavigationView {
                    AspirationMoule
                }
                .tabItem {
                    VStack {
                        Image(systemName: "text.badge.star")
                        Text("Aspirations")
                    }
                }
                .tag(4)
                
            }
            .accentColor(.white)
            .colorScheme(.dark)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: Remove all sheduled notification
    func applicationWillTerminate(_ application: UIApplication) {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
    }
    
}
