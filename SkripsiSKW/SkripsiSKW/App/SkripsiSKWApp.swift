//
//  SkripsiSKWApp.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

@main
struct SkripsiSKWApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    var body: some Scene {

        WindowGroup {
            ContentView()
                .environmentObject(SessionViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
