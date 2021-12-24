//
//  LeaderboardList.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct LeaderboardList: View {
    @Binding var listOfData: [[String]]
    var incrementIndex: Int = 0
    
    var body: some View {
        VStack {
            ForEach(Array(listOfData.enumerated()), id: \.offset){ (index, data) in
                LeaderboardRow(rowData: data, rank: index + 1 + incrementIndex)
                    .frame(height: 30)
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
        LeaderboardList(listOfData: .constant([["Jackie", "239"], ["Leon", "231"]]))
    }
}
