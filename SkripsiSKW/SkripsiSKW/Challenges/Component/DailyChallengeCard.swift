//
//  DailyChallengeCard.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 24/12/21.
//

import SwiftUI

struct DailyChallengeCard: View {
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
                Button(action: {}, label: {
                    Text("Start Workout").font(.system(size: 12)).padding(5).foregroundColor(Color.black)
                }).background(Color.yellow).cornerRadius(8)
            }.padding()
        }.frame(width: Screen.width-75, height: 187).foregroundColor(Color.white)
        
            
    }
}

struct DailyChallengeCard_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengeCard()
    }
}
