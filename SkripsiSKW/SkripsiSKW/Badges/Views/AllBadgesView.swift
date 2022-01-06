//
//  AllBadgesView.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 23/12/21.
//

import SwiftUI

struct AllBadgesView: View {
    @ObservedObject var badgesViewModel : AllBadgeViewModel
    var body: some View {
        NavigationView{
            ZStack{
                Color.sambucus
                    .ignoresSafeArea()
                ScrollView{
                    LatestBadge(badgesViewModel: badgesViewModel)
                    ListOfBadge(badgesViewModel: badgesViewModel)
                }
                Rectangle().background(Color.black).opacity(badgesViewModel.showBadgeDetail ? 0.5 : 0).onTapGesture {
                    badgesViewModel.showBadgeDetail.toggle()
                }
                BadgeAdd(isShown: badgesViewModel.showBadgeDetail).opacity(badgesViewModel.showBadgeDetail ? 1 : 0)
                
            }
        
            .navigationBarTitle(Text("Badges"))
            
        }
        .preferredColorScheme(.dark)
    }
}

