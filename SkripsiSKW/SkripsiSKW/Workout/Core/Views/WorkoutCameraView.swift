//
//  WorkoutCameraView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 28/12/21.
//

import SwiftUI

struct WorkoutCameraView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let workoutType: WorkoutType
    
    @State private var isOrientationPresent = true
    @State private var isCountdownPresent = true
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                CameraViewWrapper()
                    .ignoresSafeArea()
                
                if isCountdownPresent {
                    ZStack {
                        Color.black.opacity(0.7)
                            .ignoresSafeArea()
                        
                        if workoutType.orientation == .landscape && isOrientationPresent { // dont forget to change workouttype orientation to landscape
                            WorkoutRotationView(isOrientationPresent: $isOrientationPresent) {
                                AppDelegate.orientationLock = .landscape
                            }
                        } else {
                            WorkoutCountdownView(isCountdownPresent: $isCountdownPresent)
                        }
                    }
                } else {
                    // Vision Body Pose View
                    Text("MANTAP")
                }
            }
        }
        .onAppear {
            if workoutType.orientation == .landscape {
                AppDelegate.orientationLock = .all
            } else {
                AppDelegate.orientationLock = .portrait
            }
        }
        .onDisappear {
            AppDelegate.orientationLock = .portrait // Unlocking the rotation when leaving the view
        }
    }
}
