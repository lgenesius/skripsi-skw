//
//  BadgesView.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 21/12/21.
//

import SwiftUI

struct BadgesView: View {
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

struct BadgesView_Previews: PreviewProvider {
    static var previews: some View {
        BadgesView()
    }
}
