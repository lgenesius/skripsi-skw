//
//  WorkoutFinishView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 31/12/21.
//

import SwiftUI

struct WorkoutFinishView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var poseEstimator: PoseEstimator
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
            .padding()
            
            VStack {
                Spacer()
                
                HStack(spacing: 3) {
                    Text("\(poseEstimator.count)")
                        .modifier(TextModifier(
                            color: .white,
                            size: 100,
                            weight: .regular
                        ))
                    
                    Text("reps")
                        .modifier(TextModifier(
                            color: .white,
                            size: 34,
                            weight: .regular
                        ))
                }
                
                Text(poseEstimator.workoutType?.title ?? "Unknown")
                
                Spacer()
            }
        }
    }
}
