//
//  AppDelegate.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        NotificationCenter.default.addObserver(self, selector:#selector(calendarDayDidChange), name:.NSCalendarDayChanged, object:nil)
        
        return true
    }
    
    @objc private func calendarDayDidChange(_ notification : NSNotification) {
        CompetitionService.updateCompetition { boolean, error in
            
        }
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
