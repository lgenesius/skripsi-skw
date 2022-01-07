//
//  LeaderboardRow.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct LeaderboardRow: View {
    var rowData: CompetitionUserData
    var rank: Int
    
    var body: some View {
        HStack {
            Text("\(rank). \(rowData.userName)")
                .modifier(TextModifier(color: Color.snowflake, size: 17, weight: .bold))
            Spacer()
            Text("\(rowData.userCompetitionPoint) Points")
                .modifier(TextModifier(color: Color.notYoCheese, size: 17, weight: .bold))
        }
    }
}

struct LeaderboardRow_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardRow(rowData: CompetitionUserData(userId: "jackie leonardy", userCompetitionPoint: 123, userName: "Jack"), rank: 10)
    }
}
