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
                Text(activeCompetitionVM.competition.competitionName)
                    .modifier(TextModifier(color: Color.snowflake, size: 18, weight: .bold))
                Text("")
                Text(activeCompetitionVM.competition.competitionDescription).modifier(TextModifier(color: Color.snowflake, size: 12, weight: .regular))
                    .multilineTextAlignment(.leading)
                Spacer()
                
                if activeCompetitionVM.competition.isRunning {
                    Button(action: {}, label: {
                        Text("Competition is Running").font(.system(size: 12)).padding(5).foregroundColor(Color.black)
                    }).background(Color.notYoCheese).cornerRadius(8)
                } else {
                    Button(action: {}, label: {
                        Text("Started on \(activeCompetitionVM.competition.startDateEvent)").font(.system(size: 12)).padding(5).foregroundColor(Color.white)
                    }).background(Color.red).cornerRadius(8)
                }
                Text("From \(activeCompetitionVM.competition.startDateEvent) until \(activeCompetitionVM.competition.endDateEvent)").modifier(TextModifier(color: Color.snowflake, size: 12, weight: .bold))
                   
            }.padding()
        }.frame(width: Screen.width-75, height: 187).foregroundColor(Color.white)
    }
}

struct ActiveCompetitionCard_Previews: PreviewProvider {
    static var previews: some View {
        ActiveCompetitionCard(activeCompetitionVM: dev.activeCompetitionVM)
    }
}
