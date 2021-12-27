//
//  AllBadgesView.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 23/12/21.
//

import SwiftUI

struct AllBadgesView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.sambucus
                    .ignoresSafeArea()
                ScrollView{
                    LatestBadge()
                    ListOfBadge()
                }
                
                BadgeAdd().opacity(0)
                
            }
        
            .navigationBarTitle(Text("Badges"))
            
        }
        .preferredColorScheme(.dark)
    }
}

struct AllBadgesView_Previews: PreviewProvider {
    static var previews: some View {
        AllBadgesView()
    }
}
