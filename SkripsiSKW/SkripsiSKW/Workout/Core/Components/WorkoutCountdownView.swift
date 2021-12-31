//
//  WorkoutCountdownView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 29/12/21.
//

import SwiftUI

struct WorkoutCountdownView: View {
    @Binding var isCountdownPresent: Bool
    var completion: (() -> Void)
    
    @StateObject private var countDownManager = CountdownManager()
    
    var body: some View {
        Text(countDownManager.secondsRemaining != 0 ? "\(countDownManager.secondsRemaining)": "Go!")
            .modifier(TextModifier(
                color: countDownManager.secondsRemaining != 0 ? .white: .notYoCheese,
                size: 100,
                weight: .bold
            ))
            .onAppear(perform: {
                countDownManager.secondsRemaining = 5
                countDownManager.completion = {
                    isCountdownPresent = false
                    completion()
                }
                
                countDownManager.startCountdown()
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                countDownManager.pause()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                countDownManager.startCountdown()
            }
    }
}
