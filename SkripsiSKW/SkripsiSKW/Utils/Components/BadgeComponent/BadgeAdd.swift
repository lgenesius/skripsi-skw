//
//  BadgeAdd.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 22/12/21.
//

import SwiftUI

struct BadgeAdd: View {
    @State var isShown : Bool
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                Rectangle().fill(Color.blueDepths)
                VStack{
                    Spacer()
                    Text("Title").bold()
                    Image(systemName: "circle.fill").resizable().frame(width: 94, height: 94).foregroundColor(Color.yellow)
                    
                    Text("Short Description").font(.system(size: 11)).frame(width: 173, height: 49)
                    
                    Text("Recieved on 03/02/2020").bold().font(.system(size: 9)).foregroundColor(.white).padding(.bottom, 9)
                }.foregroundColor(Color.white)
            }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3.5).cornerRadius(13)
        
            
            Button(action: { isShown.toggle() }, label: {
                Text("Add to Highlight").bold().foregroundColor(.white)
            }).frame(width: UIScreen.main.bounds.width/2).padding(.vertical, 5).border(Color.insignia).background(Color.insignia).cornerRadius(8)
            
        }
    }
}

