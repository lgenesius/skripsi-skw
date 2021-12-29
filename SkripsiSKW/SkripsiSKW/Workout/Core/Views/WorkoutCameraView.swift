//
//  WorkoutCameraView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 28/12/21.
//

import SwiftUI

struct WorkoutCameraView: View {
    let workoutType: WorkoutType
    
    @State private var isOrientationPresent = true
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                CameraViewWrapper()
                
                if workoutType.orientation == .portrait && isOrientationPresent {
                    WorkoutRotationView(isOrientationPresent: $isOrientationPresent) {
                        print("hehe")
                    }
                }
            }
        }
    }
}
