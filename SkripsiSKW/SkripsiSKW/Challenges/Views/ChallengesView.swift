//
//  ChallengesView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import SwiftUI

struct ChallengesView: View {
    @EnvironmentObject var sessionVM: SessionViewModel
    
    var body: some View {
        Button {
            sessionVM.logout()
        } label: {
            Text("Logout")
        }

    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
