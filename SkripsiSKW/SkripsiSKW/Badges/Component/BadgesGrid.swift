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
        VStack{
            LazyVGrid(columns: columnsLayout){
               
                    Image(Color.red).resizable().frame(width: Screen.width/3.5, height: Screen.height/6)
                
                
            }
        }
    }
}

struct BadgesGrid_Previews: PreviewProvider {
    static var previews: some View {
        BadgesGrid()
    }
}
