//
//  BadgeItem.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 05/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

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
                        WebImage(url: URL(string: badgeViewModel.userBadge.image))
                                                    .resizable()
                                                    .indicator(.activity)
                                                    .scaledToFill()
                                                    .frame(width: 70, height: 70)
                                                    .clipShape(Circle())
                                                    .foregroundColor(Color.yellow)
                    }.padding(.horizontal,8)
                    Rectangle().fill(Color.black).opacity(badgeViewModel.userBadge.progress < badgeViewModel.userBadge.goal ? 0.3 : 0).cornerRadius(13)
                }
                
            )
        
        
    }
}

struct BadgeItem_Previews: PreviewProvider {
    static var previews: some View {
        BadgeItem(badgeViewModel: dev.userBadgeVM)
    }
}

