//
//  WorkoutInfoView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct WorkoutInfoView: View {
    let workoutType: WorkoutType
    
    @State var currentIndex = 0
    
    var body: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            VStack {
                SkipButtonView(currentIndex: $currentIndex)
                
                InfoTabView(currentIndex: $currentIndex)
            }
        }
        .navigationBarHidden(true)
    }
}
