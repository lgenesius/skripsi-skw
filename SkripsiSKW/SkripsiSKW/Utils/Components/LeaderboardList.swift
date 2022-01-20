//
//  LeaderboardList.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct LeaderboardList: View {
    @Binding var listOfData: [CompetitionUserData]
    @EnvironmentObject var sessionVM: SessionViewModel
    var incrementIndex: Int = 0
    @StateObject var badgesViewModel = BadgeListViewModel()
    
    var body: some View {
        VStack {
            ForEach(Array(listOfData.enumerated()), id: \.offset){ (index, data) in
            
                NavigationLink {
                    if data.userId == sessionVM.authUser?.uid {
                        ProfileView(from: .competition, badgesViewModel: badgesViewModel)
                    } else {
                        LeaderboardRowDetail(leaderbordVM: LeaderboardRowDetailViewModel(userId: data.userId, sessionVM: sessionVM.authUser!), rank: index+1+incrementIndex, userID: data.userId)
                    }
                } label: {
                    LeaderboardRow(rowData: data, rank: index + 1 + incrementIndex, textColor: sessionVM.authUser?.uid == data.userId ? Color.notYoCheese : Color.snowflake)
                        .frame(height: 30)
                }
            }
        }
        .padding()
        .frame(height: CGFloat(listOfData.count * 40))
        .background(Color.midnightExpress)
        .cornerRadius(15.0)
    }
}

struct LeaderboardList_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardList(listOfData:
        .constant( [CompetitionUserData(userId: "Jackie", userCompetitionPoint: 123, userName: "Jack"), CompetitionUserData(userId: "Leon", userCompetitionPoint: 100, userName: "Leyon")]))
    }
}
