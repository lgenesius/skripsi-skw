//
//  LeaderboardRow.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct LeaderboardRow: View {
    var rowData: [String]
    var rank: Int
    
    var body: some View {
        HStack {
            Text("\(rank). \(rowData[0])")
                .modifier(TextModifier(color: Color.snowflake, size: 17, weight: .bold))
            Spacer()
            Text("\(rowData[1]) Points")
                .modifier(TextModifier(color: Color.notYoCheese, size: 17, weight: .bold))
        }
    }
}

struct LeaderboardRow_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardRow(rowData: ["Jackie Leonardy", "231"], rank: 1)
    }
}
