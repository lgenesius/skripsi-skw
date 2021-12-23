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
                ScrollView{
                    BadgeLatest()
                    BadgesGrid()
                }.padding()
                
                
            }
        
        .navigationBarTitle(Text("Badges"))
        }
    }
}

struct AllBadgesView_Previews: PreviewProvider {
    static var previews: some View {
        AllBadgesView()
    }
}
