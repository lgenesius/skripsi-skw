//
//  ExercisesList.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 20/12/21.
//

import SwiftUI

struct ExercisesList: View {
    @Binding var isAlertPresent: Bool
    @Binding var alertIdentifier: AlertIdentifier
    @Binding var selectedExercises: WorkoutType
    
    @State private var isDropDown = true
    private let exercises: [WorkoutType] = [.squat, .pushup, .plank]
    
    var body: some View {
        VStack {
            HStack {
                Text("List of Exercises")
                    .modifier(TextModifier(color: .white, size: 24, weight: .medium))
                Spacer()
                Button {
                    withAnimation {
                        isDropDown.toggle()
                    }
                } label: {
                    Image(systemName: isDropDown ? "chevron.down": "chevron.up")
                        .foregroundColor(.notYoCheese)
                        .frame(width: 20, height: 20)
                }
            }
            
            
            if isDropDown {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(0..<3) { index in
                            Button {
                                selectCardAction(index: index)
                            } label: {
                                ExerciseCard()
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private func selectCardAction(index: Int) {
        selectedExercises = exercises[index]
        
        let status = CameraAuthorizationManager.getCameraAuthorizationStatus()
        if status == .unauthorized {
            alertIdentifier = .openSettings
            isAlertPresent = true
            return
        }
        
        alertIdentifier = .caution
       isAlertPresent = true
    }
}
