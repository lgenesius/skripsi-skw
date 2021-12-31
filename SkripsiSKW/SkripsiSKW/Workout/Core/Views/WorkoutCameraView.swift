//
//  WorkoutCameraView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 28/12/21.
//

import SwiftUI

struct WorkoutCameraView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let workoutType: WorkoutType
    
    @StateObject private var poseEstimator = PoseEstimator()
    @State private var isOrientationPresent = true
    @State private var isCountdownPresent = true
    @State private var isWorkoutFinish = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                CameraViewWrapper(poseEstimator: poseEstimator)
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
                            WorkoutCountdownView(isCountdownPresent: $isCountdownPresent, completion: {
                                poseEstimator.isActive = true
                                poseEstimator.start()
                            })
                        }
                    }
                } else {
                    // Vision Body Pose View
                    StickFigureView(poseEstimator: poseEstimator, size: geo.size)
                    
                    WorkoutTimerPointView(poseEstimator: poseEstimator, isWorkoutFinish: $isWorkoutFinish)
                }
            }
        }
        .onAppear {
            poseEstimator.workoutType = workoutType
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
