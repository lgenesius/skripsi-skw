//
//  BadgeLatest.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 22/12/21.
//

import SwiftUI

struct BadgeLatest: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Latest Badge" ).font(.system(size: 24))
            HStack{
                ForEach((0...2), id: \.self) {_ in
                    BadgeItem()
                }
            }
                
            
        }.padding()
    }
}

struct BadgeLatest_Previews: PreviewProvider {
    static var previews: some View {
        BadgeLatest()
    }
}
