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
            Rectangle().fill(Color.blueDepths).frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3.5).overlay(
                Text("Recieved on 03/02/2020").font(.system(size: 11)).foregroundColor(.white).padding(.bottom, 5)
            ,alignment: .bottom).cornerRadius(15)
            Button(action: {}, label: {
                Text("Add to Highlight").foregroundColor(.white)
            }).frame(width: UIScreen.main.bounds.width/2).padding(.vertical, 5).border(Color.insignia).background(Color.insignia).cornerRadius(8)
            
        }
    }
}

struct BadgeAdd_Previews: PreviewProvider {
    static var previews: some View {
        BadgeAdd()
    }
}
