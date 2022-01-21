//
//  WorkoutTimerPointView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 30/12/21.
//

import SwiftUI

struct WorkoutTimerPointView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var poseEstimator: PoseEstimator
    @ObservedObject var activeCompetitionVM: ActiveCompetitionListViewModel
    
    @Binding var isWorkoutFinish: Bool
    
    @StateObject private var countdownManager = CountdownManager()
    
    var body: some View {
        VStack {
            if AppDelegate.orientationLock == .portrait {
                HStack {
                    Spacer()
                    countdownText
                    Spacer()
                }
                HStack {
                    Spacer()
                    countText
                    Spacer()
                }
                Spacer()
            } else {
                HStack {
                    countText
                    Spacer()
                    countdownText
                }
                .padding()
                Spacer()
            }
        }
        .onAppear(perform: {
            countdownManager.secondsRemaining = poseEstimator.getWorkoutSeconds()
            countdownManager.completion = {
                withAnimation {
                    isWorkoutFinish = true
                    //MARK: Uncomment kalau emang butuh untuk update data langsung ke database
                    activeCompetitionVM.updateAllData(by: poseEstimator.count)
                    UserService.updateBadge(with: poseEstimator.workoutType!.title, point: poseEstimator.count) { error in

                    }
                    
                    DailyChallengeService.updateDailyChallenge(with: poseEstimator.workoutType!.title, point: poseEstimator.count) { error in
                        
                    }
                    
                    UserService.updateUserPoint(point: poseEstimator.count) { error in
                        
                    }
                }
                poseEstimator.isActive = false
            }
            
            countdownManager.startCountdown()
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            countdownManager.pause()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if poseEstimator.isActive {
                countdownManager.startCountdown()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            if poseEstimator.isActive {
                countdownManager.startIfPaused()
            }
        }
    }
    
    @ViewBuilder
    var countdownText: some View {
//        if #available(iOS 15.0, *) {
//            RoundedRectangle(cornerRadius: 13)
//                .fill(Color.notYoCheese)
//                .frame(width: 186, height: 105)
//                .overlay {
//                    Text("\(timeString(time: countdownManager.secondsRemaining))")
//                        .modifier(TextModifier(
//                            color: .white,
//                            size: 48,
//                            weight: .medium
//                        ))
//                }
//        } else {
            // Fallback on earlier versions
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.notYoCheese)
                .frame(width: 186, height: 105)
                .overlay(
                    Text("\(timeString(time: countdownManager.secondsRemaining))")
                        .modifier(TextModifier(
                            color: .white,
                            size: 48,
                            weight: .medium
                        ))
                )
//        }
    }
    
    @ViewBuilder
    var countText: some View {
//        if #available(iOS 15.0, *) {
//            RoundedRectangle(cornerRadius: 13)
//                .fill(Color.notYoCheese)
//                .frame(width: 105, height: 105)
//                .overlay {
//                    Text("\(poseEstimator.count)")
//                        .modifier(TextModifier(
//                            color: .white,
//                            size: 48,
//                            weight: .medium
//                        ))
//                }
//        } else {
            // Fallback on earlier versions
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.notYoCheese)
                .frame(width: 105, height: 105)
                .overlay(
                    Text("\(poseEstimator.count)")
                        .modifier(TextModifier(
                            color: .white,
                            size: 48,
                            weight: .medium
                        ))
                )
//        }
    }
    
    private func timeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
