//
//  WorkoutNavigation.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 25/12/21.
//

import SwiftUI

struct WorkoutNavigation: View {
    let workoutType: WorkoutType
    
    @State private var isInfoPresent = true
    @ObservedObject var activeCompetitionVM: ActiveCompetitionListViewModel
    
    init(workout: WorkoutType, activeCompetitionVM: ActiveCompetitionListViewModel) {
        workoutType = workout
        self.activeCompetitionVM = activeCompetitionVM
    }
    
    var body: some View {
        if !workoutType.getDefaultStatus() && isInfoPresent {
            WorkoutInfoView(status: $isInfoPresent, workout: workoutType)
        } else {
            WorkoutCameraView(workoutType: workoutType, activeCompetitionVM: activeCompetitionVM)
        }
    }
}
