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
    
    init(workout: WorkoutType) {
        workoutType = workout
    }
    
    var body: some View {
        if !workoutType.getDefaultStatus() && isInfoPresent {
            WorkoutInfoView(status: $isInfoPresent, workout: workoutType)
        } else {
            WorkoutCameraView(workoutType: workoutType)
        }
    }
}
