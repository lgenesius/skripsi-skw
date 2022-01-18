//
//  LatestBadge.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 27/12/21.
//

import SwiftUI

struct LatestBadge: View {
    var badgesViewModel : [BadgeViewModel]
    @ObservedObject var badgesListVM : BadgeListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Latest Badges")
                .modifier(TextModifier(
                    color: .white,
                    size: 24,
                    weight: .medium
                ))
            
            HStack(spacing: 15) {
                if badgesViewModel.isEmpty{
                    Text("Theres is no latest badge yet")
                }else{
                    ForEach(badgesViewModel) { badgeVM in
                        BadgeItem(badgeViewModel: badgeVM) .onTapGesture {
                            badgesListVM.selectBadgeViewModel(badgeVM: badgeVM)
                            badgesListVM.showBadgeDetail.toggle()
                        }
                    }
                }
                
            }
        }
        .padding(.top, 20)
        .padding(.horizontal)
    }
}

