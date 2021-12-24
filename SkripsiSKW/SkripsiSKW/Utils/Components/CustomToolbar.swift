//
//  CustomToolbar.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct CustomToolbarTwoButtons: ToolbarContent {
    let toolbarLeadingTitle: String
    let leadingAction: () -> ()
    let toolbarTrailingTitle: String
    let trailingAction: () -> ()
    

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button ( action: self.leadingAction, label: {
                Text(self.toolbarLeadingTitle)
                    .foregroundColor(.notYoCheese)
            })
        }

        ToolbarItem(placement: .navigationBarTrailing) {
            Button ( action: self.trailingAction, label: {
                Text(self.toolbarTrailingTitle)
                    .foregroundColor(.notYoCheese)
            })
        }
    }
}
