//
//  BadgeItem.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 21/12/21.
//

import SwiftUI

struct BadgeItem: View {
    var body: some View {
        Rectangle().fill(Color.red).frame(width: UIScreen.main.bounds.width/3.5, height: UIScreen.main.bounds.height/6).cornerRadius(10)
    }
}

struct BadgeItem_Previews: PreviewProvider {
    static var previews: some View {
        BadgeItem()
    }
}
