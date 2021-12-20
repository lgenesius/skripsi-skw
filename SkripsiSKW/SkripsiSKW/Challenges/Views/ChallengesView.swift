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
            
            competitionButtons
            
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
            Text(DateManager.shared.getCurrentDayAndDateLongVersion())
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
    
    @ViewBuilder
    var competitionButtons: some View {
        HStack {
            Button {
                print("Join competition")
            } label: {
                Text("Join a Competition")
                    .font(Font.system(size: 14, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .frame(width: 165, height: 37)
                    .background(Color.insignia)
                    .cornerRadius(6)
            }

            Spacer()
            
            Button {
                print("Create competition")
            } label: {
                Text("Create a Competition")
                    .font(Font.system(size: 14, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .frame(width: 165, height: 37)
                    .background(Color.insignia)
                    .cornerRadius(6)
            }
        }
        .padding(.horizontal)
    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
