//
//  DailyChallengeCard.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 24/12/21.
//

import SwiftUI

struct DailyChallengeCard: View {
    @ObservedObject var dailyChallengeVM: DailyChallengeViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading){

            Color.blueDepths.ignoresSafeArea()
            
                
            VStack(alignment: .leading){
                HStack(){
                    Text(dailyChallengeVM.challenge.challengeName).modifier(TextModifier(color: Color.snowflake, size: 18, weight: .bold))
                    Text("(\(dailyChallengeVM.challenge.challengeGoal) Times )").font(.system(size: 18)).fontWeight(.regular)
                }
                Spacer()
                if(dailyChallengeVM.dailyChallengeUserData.isCompleted) {
                    HStack(spacing: 20){
                        ProgressBar(value: $dailyChallengeVM.dummyTotalPointPercentage, backgroundColor: Color.snowflake, progressBarColor: Color.green, height: CGFloat(10))
                        Text("\(dailyChallengeVM.dailyChallengeUserData.progress) / \(dailyChallengeVM.challenge.challengeGoal)").font(.system(size: 12)).fontWeight(.bold)
                    }
                } else {
                    HStack(spacing: 20){
                        ProgressBar(value: $dailyChallengeVM.dummyTotalPointPercentage, backgroundColor: Color.snowflake, progressBarColor: Color.notYoCheese, height: CGFloat(10))
                        Text("\(dailyChallengeVM.dailyChallengeUserData.progress) / \(dailyChallengeVM.challenge.challengeGoal)").font(.system(size: 12)).fontWeight(.bold)
                    }
                }
            }.padding()
        }.cornerRadius(13)
        .shadow(color: Color.black, radius: 2, x: 0, y: 3)
    }
}


struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            
            .background(Color.white)
            .scaleEffect(x: 1, y: 2, anchor: .center)
            .frame( height: 7)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
    }
}

struct DailyChallengeCard_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengeCard(dailyChallengeVM: dev.dailyChallengeVM)
    }
}
