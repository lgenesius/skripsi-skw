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
        VStack {
            dateAndPhotoProfile
            
            titleApp
            
            Button {
                sessionVM.logout()
            } label: {
                Text("Logout")
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

extension ChallengesView {
    
    @ViewBuilder
    var dateAndPhotoProfile: some View {
        HStack {
            Text("Monday, October 25")
                .foregroundColor(Color.notYoCheese)
                .font(Font.system(size: 17))
            Spacer()
            Circle()
                .frame(width: 36, height: 36)
                .foregroundColor(Color.notYoCheese)
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    @ViewBuilder
    var titleApp: some View {
        HStack {
            Text("Nama App")
                .foregroundColor(.white)
                .font(Font.system(size: 34, weight: .medium, design: .default))
            Spacer()
        }
        .padding(.leading)
    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
