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
    
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                Color.blueDepths.ignoresSafeArea()
                VStack(spacing: 10){
                    Text("Description").bold()
                    Text("\(dailyChallengeVM.challenge.challengeDescription)").font(.system(size: 11))
                    Spacer()
                    HStack (spacing: 0){
                        Text("Reward: ").modifier(TextModifier(color: Color.snowflake, size: 14, weight: .medium))
                        Text("\(dailyChallengeVM.challenge.challengeCompletion) Points").modifier(TextModifier(color: Color.notYoCheese, size: 14, weight: .black))
                    }
                    if dailyChallengeVM.challenge.challengeIdentifier == "PushUp" {
                        NavigationLink {
                           CreateChallengeView()
                        } label: {
                            Text("Start Push Up")
                                .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                                .frame(width: 165, height: 37)
                                .background(Color.insignia)
                                .cornerRadius(6)
                        }
                    } else if dailyChallengeVM.challenge.challengeIdentifier == "Squat" {
                        NavigationLink {
                           CreateChallengeView()
                        } label: {
                            Text("Start Squat")
                                .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                                .frame(width: 165, height: 37)
                                .background(Color.insignia)
                                .cornerRadius(6)
                        }
                    }

                }.padding(.init(top: 20, leading: 16, bottom: 16, trailing: 16))
            }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3.5).cornerRadius(13)
        }
            
    }
}

struct DailyChallengePopOver_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengePopOver(dailyChallengeVM: DailyChallengeViewModel(challenge: dev.challenge), dailyChallengeListVM: DailyChallengeListViewModel())
    }
}
