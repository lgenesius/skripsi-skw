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
    @State private var badgeAlert = false
    var body: some View {
        ZStack{
            Color.sambucus
                .ignoresSafeArea()
            ScrollView{
                LatestBadge(badgesViewModel: badgesListVM.latestBadge(), badgesListVM: badgesListVM)
                ListOfBadge(badgesViewModel: badgesListVM.userBadgeListViewModel, badgesListVM: badgesListVM)
            }
            Rectangle().fill(Color.black).opacity(badgesListVM.showBadgeDetail ? 0.5 : 0).onTapGesture {
                withAnimation {
                    badgesListVM.showBadgeDetail.toggle()
                }
            }
            BadgeAdd(badgesViewModel: badgesListVM.selectedBadgeViewModel, badgesListVM: badgesListVM, errorAlert: $badgeAlert).opacity(badgesListVM.showBadgeDetail  ? 1 : 0)
            
        }
        .navigationTitle(Text("Badges"))
        .preferredColorScheme(.dark)
        .alert(isPresented: $badgeAlert) {
            Alert(title: Text("Highlighted Badge Limit"), message: Text("You can't put more than 3 highlight badge, remove one"), dismissButton: .cancel(Text("Ok"), action:{
            }))
        }
    }
}

