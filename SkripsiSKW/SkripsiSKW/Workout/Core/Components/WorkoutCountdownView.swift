//
//  WorkoutCountdownView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 29/12/21.
//

import SwiftUI

struct WorkoutCountdownView: View {
    @Binding var isCountdownPresent: Bool
    
    @State private var isActive = true
    @State private var timeRemaining = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        Text(timeRemaining != 0 ? "\(timeRemaining)": "Go!")
            .modifier(TextModifier(
                color: timeRemaining != 0 ? .white: .notYoCheese,
                size: 100,
                weight: .bold
            ))
            .onReceive(timer) { time in
                guard isActive else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    isCountdownPresent = false
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                isActive = false
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                isActive = true
            }
    }
}
