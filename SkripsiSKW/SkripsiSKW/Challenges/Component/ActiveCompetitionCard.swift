//
//  ActiveCompetitionCard.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import SwiftUI

struct ActiveCompetitionCard: View {
    var activeCompetitionVM: ActiveCompetitionViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Image("placeholderImage")
            
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.75) ,.clear]), startPoint: .leading, endPoint: .trailing)
                ).cornerRadius(13)
              
            
                
            VStack(alignment: .leading){
                Text(activeCompetitionVM.competition.competitionName).font(.system(size: 18))
                Text("")
                Text(activeCompetitionVM.competition.competitionDescription).font(.system(size: 12))
                Spacer()
                
                Button(action: {}, label: {
                    Text("Start Workout").font(.system(size: 12)).padding(5).foregroundColor(Color.black)
                }).background(Color.yellow).cornerRadius(8)
                   
            }.padding()
        }.frame(width: Screen.width-75, height: 187).foregroundColor(Color.white)
    }
}
