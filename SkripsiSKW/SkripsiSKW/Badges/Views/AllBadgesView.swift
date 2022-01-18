//
//  AllBadgesView.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 23/12/21.
//

import SwiftUI

struct AllBadgesView: View {
    var badgesViewModel : [BadgeViewModel]
    @ObservedObject var badgesListVM : BadgeListViewModel
    
    var body: some View {
        ZStack{
            Color.sambucus
                .ignoresSafeArea()
            ScrollView{
                LatestBadge(badgesViewModel: badgesListVM.latestBadge(), badgesListVM: badgesListVM)
                ListOfBadge(badgesViewModel: badgesListVM.userBadgeListViewModel, badgesListVM: badgesListVM)
            }
            Rectangle().fill(Color.black).opacity(badgesListVM.showBadgeDetail ? 0.5 : 0).onTapGesture {
                badgesListVM.showBadgeDetail.toggle()
            }
            BadgeAdd(badgesViewModel: badgesListVM.selectedBadgeViewModel, badgesListVM: badgesListVM ).opacity(badgesListVM.showBadgeDetail  ? 1 : 0)
            
        }
        .navigationTitle(Text("Badges"))
        .preferredColorScheme(.dark)
    }
}

