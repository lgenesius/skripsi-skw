//
//  JoinChallengeView.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct JoinChallengeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color.sambucus.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 24) {
                
            }
            .padding(.top, 24)
            .navigationTitle("Join Competition")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                CustomToolbarTwoButtons(toolbarLeadingTitle: "Cancel", leadingAction: {
                    presentationMode.wrappedValue.dismiss()
                }, toolbarTrailingTitle: "Save") {
                    
                }
            }
        }
    }
}

struct JoinChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        JoinChallengeView()
    }
}
