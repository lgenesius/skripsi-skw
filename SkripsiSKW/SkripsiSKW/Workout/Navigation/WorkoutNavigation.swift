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
    @State private var isOrientationPresent = true
    
    init(workout: WorkoutType) {
        workoutType = workout
    }
    
    var body: some View {
        if !workoutType.getDefaultStatus() && isInfoPresent {
            WorkoutInfoView(status: $isInfoPresent, workout: workoutType)
        } else if workoutType.orientation == .landscape && isOrientationPresent {
            Text("Mantap")
        } else {
            Text("Hoho")
        }
    }
}
