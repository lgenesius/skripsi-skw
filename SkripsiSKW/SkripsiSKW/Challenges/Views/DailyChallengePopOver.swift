//
//  DailyChallengePopOver.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 19/01/22.
//

import SwiftUI

struct DailyChallengePopOver: View {
    @ObservedObject var dailyChallengeVM : DailyChallengeViewModel
    @ObservedObject var dailyChallengeListVM: DailyChallengeListViewModel
    @Binding var selectedExercises: WorkoutType
    @Binding var alertIdentifier: AlertIdentifier
    @Binding var isAlertPresent: Bool
    
    var body: some View {

        VStack(spacing: 10){
            Text("Description").bold()
            Text("\(dailyChallengeVM.challenge.challengeDescription)").font(.system(size: 11))
                .multilineTextAlignment(.center)
            Spacer()
            HStack (spacing: 0){
                Text("Reward: ").modifier(TextModifier(color: Color.snowflake, size: 14, weight: .medium))
                Text("\(dailyChallengeVM.challenge.challengeCompletion) Points").modifier(TextModifier(color: Color.notYoCheese, size: 14, weight: .black))
            }
            if dailyChallengeVM.challenge.challengeIdentifier == "PushUp" {
                Button {
                    selectCardAction(workoutType: .pushup)
                } label: {
                    Text("Start Push Up")
                        .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                        .frame(width: 165, height: 37)
                        .background(Color.insignia)
                        .cornerRadius(6)
                }
            } else if dailyChallengeVM.challenge.challengeIdentifier == "Squat" {
                Button {
                    selectCardAction(workoutType: .squat)
                } label: {
                    Text("Start Squat")
                        .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                        .frame(width: 165, height: 37)
                        .background(Color.insignia)
                        .cornerRadius(6)
                }
            }

        }.padding(.init(top: 20, leading: 16, bottom: 16, trailing: 16))
        .background(Color.blueDepths)
    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3.5).cornerRadius(13)
            
    }
    
    private func selectCardAction(workoutType: WorkoutType) {
        selectedExercises = workoutType
        
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

//struct DailyChallengePopOver_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyChallengePopOver(dailyChallengeVM: DailyChallengeViewModel(challenge: dev.challenge), dailyChallengeListVM: DailyChallengeListViewModel())
//    }
//}
