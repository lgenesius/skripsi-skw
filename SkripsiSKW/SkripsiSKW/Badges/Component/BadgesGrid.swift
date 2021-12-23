//
//  BadgesGrid.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 21/12/21.
//

import SwiftUI

struct BadgesGrid: View {
    let columnsLayout = [
        GridItem(.flexible(minimum: 10), spacing: 0), GridItem(.flexible(minimum: 10), spacing: 0), GridItem(.flexible(minimum: 10), spacing: 0)
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("All Badge" ).font(.system(size: 24))
            LazyVGrid(columns: columnsLayout){
                ForEach((1...10), id: \.self) {_ in
                    BadgeItem()
                }
                
                
                
            }
        }.padding()
    }
}

struct BadgesGrid_Previews: PreviewProvider {
    static var previews: some View {
        BadgesGrid()
    }
}
