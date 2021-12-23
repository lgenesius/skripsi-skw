//
//  BadgeAdd.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 22/12/21.
//

import SwiftUI

struct BadgeAdd: View {
    var body: some View {
        VStack(alignment: .center){
            Rectangle().fill(Color.red).frame(width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/3.5).overlay(
                Text("03/02/2020").font(.system(size: 11)).padding(.bottom, 5)
            ,alignment: .bottom).cornerRadius(10)
            Button(action: {}, label: {
                Text("Add to Highlighr")
            }).padding(.horizontal).padding(.vertical, 3).border(Color.red).background(Color.red).cornerRadius(10)
            
        }
    }
}

struct BadgeAdd_Previews: PreviewProvider {
    static var previews: some View {
        BadgeAdd()
    }
}
