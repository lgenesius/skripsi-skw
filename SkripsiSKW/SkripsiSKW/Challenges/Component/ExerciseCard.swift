//
//  ExerciseCard.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 27/12/21.
//

import SwiftUI

struct ExerciseCard: View {
    let title: String
    let description: String
    let image: String
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Image(image)
                .resizable()
                .scaledToFill()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.75) ,.clear]), startPoint: .leading, endPoint: .trailing)
                ).cornerRadius(13)
              
            
                
            VStack(alignment: .leading){
                Text(title).font(.system(size: 18))
                Text("")
                Text(description)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                Spacer()
                
                Button(action: {}, label: {
                    Text("Start Workout").font(.system(size: 12)).padding(5).foregroundColor(Color.black)
                }).background(Color.yellow).cornerRadius(8)
                   
            }.padding()
        }.frame(width: Screen.width-75, height: 187).foregroundColor(Color.white)
    }
}
