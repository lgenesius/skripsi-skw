//
//  PlainButton.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 23/12/21.
//

import SwiftUI

struct PlainButton: View {
    let label: String
    let action: () -> ()
    
    var body: some View {
        Button (action: self.action, label: {
            Text(self.label)
                .modifier(TextModifier(color: Color.snowflake, size: 17, weight: .bold))
        }).buttonStyle(.plain)
    }
}

struct PlainButton_Previews: PreviewProvider {
    static var previews: some View {
        PlainButton(label: "Export All") {
            
        }
    }
}
