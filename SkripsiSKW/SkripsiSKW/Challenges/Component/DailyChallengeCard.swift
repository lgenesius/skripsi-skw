//
//  DailyChallengeCard.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 24/12/21.
//

import SwiftUI

struct DailyChallengeCard: View {
    var dailyChallengeVM: DailyChallengeViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Image("placeholderImage")
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.75) ,.clear]), startPoint: .leading, endPoint: .trailing)
                ).cornerRadius(13)
              
            
                
            VStack(alignment: .leading){
                Text("asd").font(.system(size: 18))
                Text("")
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sit vitae, justo, eu, blandit parturient. Et ut purus viverra vestibulum id at a.").font(.system(size: 12))
                Spacer()
                HStack{
                    ProgressView( value: 0.5).accentColor(Color.yellow)
                    Text("(16/32)").font(.system(size: 12)).fontWeight(.bold)
                }.frame(width: (Screen.width-75)/1.5)
                    .progressViewStyle(DarkBlueShadowProgressViewStyle())
                   

                Button(action: {}, label: {
                    Text("Start Workout").font(.system(size: 12)).padding(5).foregroundColor(Color.black)
                }).background(Color.yellow).cornerRadius(8)
                   
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
