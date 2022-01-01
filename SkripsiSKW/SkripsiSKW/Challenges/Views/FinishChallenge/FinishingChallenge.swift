//
//  FinishingChallenge.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 28/12/21.
//

import SwiftUI

struct FinishingChallenge: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let workoutType: WorkoutType
    let score: Int
    @Binding var isAppear: Bool
    
    init(workout: WorkoutType, score: Int, isAppear: Binding<Bool>) {
        workoutType = workout
        self.score = score
        _isAppear = isAppear
    }
    
    var body: some View {
        if isAppear {
            CustomViewWrapper(content: {
                finishingView
            }, color: Color.black.opacity(0.85))
            .animation(.easeInOut(duration: 0.5))
        }
    }
}

extension FinishingChallenge {
    
    @ViewBuilder
    private var xButton: some View {
        HStack {
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
            }
        }
        .padding()
        
    }
    
    private var finishingView: some View {
        VStack {
            xButton
            Spacer()
            HStack {
                Text("\(score)")
                    .modifier(TextModifier(color: Color.snowflake, size: 100, weight: .bold))
                Text(self.score > 1 ? "reps" : "rep")
                    .modifier(TextModifier(color: Color.snowflake, size: 34, weight: .regular))
            }
            Text(workoutType.title)
                .modifier(TextModifier(color: Color.snowflake, size: 24, weight: .regular))
            Spacer()
            Text("You’re Currently Rank 1st!")
                .modifier(TextModifier(color: Color.notYoCheese, size: 30, weight: .semibold))
                .padding(.horizontal, 24)
                .multilineTextAlignment(.center)

            Spacer()
        }
    }
    
    @ViewBuilder
    private var mainView: some View {
        switch workoutType {
            case .pushup, .plank:
                finishingView
            
            case .squat:
                finishingView
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    AppDelegate.orientationLock = .landscapeRight
                }
        }
    }
}
struct FinishingChallenge_Previews: PreviewProvider {
    static var previews: some View {
        FinishingChallenge(workout: .pushup, score: 24, isAppear: .constant(true))
    }
}
