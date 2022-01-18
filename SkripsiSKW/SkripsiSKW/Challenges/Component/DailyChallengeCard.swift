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
            Image("placeholderImage")
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.75) ,.clear]), startPoint: .leading, endPoint: .trailing)
                ).cornerRadius(13)
              
            
                
            VStack(alignment: .leading){
                HStack(){
                    Text(dailyChallengeVM.challenge.challengeName).modifier(TextModifier(color: Color.snowflake, size: 18, weight: .bold))
                    Text("(\(dailyChallengeVM.challenge.challengeGoal))").font(.system(size: 18)).fontWeight(.regular)
                }
                Text("")
                Text(dailyChallengeVM.challenge.challengeDescription).font(.system(size: 12))
                Spacer()
                if(dailyChallengeVM.dailyChallengeUserData.isCompleted) {
                    Text("Completed").modifier(TextModifier(color: Color.green, size: 15, weight: .medium))
                } else {
                    Text("On Going").modifier(TextModifier(color: Color.red, size: 15, weight: .medium))
                }
                HStack{
                    ProgressBar(value: $dailyChallengeVM.dummyTotalPointPercentage, backgroundColor: Color.snowflake, progressBarColor: Color.notYoCheese, height: CGFloat(10))
                    Text("\(dailyChallengeVM.dailyChallengeUserData.progress) / \(dailyChallengeVM.challenge.challengeGoal)").font(.system(size: 12)).fontWeight(.bold)
                }.frame(width: (Screen.width-75)/1.5)

             
                   

//                Button(action: {}, label: {
//                    Text("Start Workout").font(.system(size: 12)).padding(5).foregroundColor(Color.black)
//                }).background(Color.yellow).cornerRadius(8)
                   
            }.padding()
        }.frame(width: Screen.width-75, height: 187).foregroundColor(Color.white)
        
            
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
