//
//  BadgeItem.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 05/01/22.
//

import SwiftUI

struct BadgeItem: View {
    var badgeViewModel: BadgeViewModel
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 13)
            .fill(Color.blueDepths)
            .frame(maxWidth: .infinity, minHeight: 125)
            .overlay(
                ZStack{
                    VStack(alignment: .center){
                        Text("\(badgeViewModel.userBadge.name)").font(.system(size: 14)).foregroundColor(Color.white).multilineTextAlignment(.center)
                        Image(systemName: "circle.fill").resizable()
                            .foregroundColor(Color.yellow).frame(width: 70, height: 70)
                    }
                    if true {
                        Rectangle().fill(Color.black).opacity(true ? 0.5 :0)
                    }
                }
                
            )
        
        
    }
}

struct BadgeItem_Previews: PreviewProvider {
    static var previews: some View {
        BadgeItem(badgeViewModel: dev.userBadgeVM)
    }
}

