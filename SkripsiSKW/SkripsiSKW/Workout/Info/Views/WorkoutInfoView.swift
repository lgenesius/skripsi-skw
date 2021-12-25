//
//  WorkoutInfoView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct WorkoutInfoView: View {
    @Binding var isInfoPresent: Bool
    let workoutType: WorkoutType
    let infos: [Info]
    
    init(status: Binding<Bool>, workout: WorkoutType) {
        _isInfoPresent = status
        workoutType = workout
        infos = Infos.getInfos(workoutType: workoutType)
    }
    
    @State var currentIndex = 0
    
    var body: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            VStack {
                SkipButtonView(currentIndex: $currentIndex)
                
                InfoTabView(
                    isInfoPresent: $isInfoPresent,
                    currentIndex: $currentIndex,
                    infos: infos
                )
                
                TabIndicator(
                    count: 3,
                    current: $currentIndex
                )
            }
        }
        .navigationBarHidden(true)
    }
}
