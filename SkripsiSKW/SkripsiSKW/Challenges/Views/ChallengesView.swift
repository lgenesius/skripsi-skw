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
            
            ScrollView {
                LazyVStack {
                    competitionButtons
                    
                    DailyChallengesView(dailyChallengeListVM: DailyChallengeListViewModel())
                    
                    ExercisesList()
                    
                    ActiveCompetitions(activeCompetitionVM: ActiveCompetitionListViewModel())
                    
                    BadgesView()
                }
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
                .modifier(TextModifier(color: .notYoCheese, size: 17, weight: .regular))
            Spacer()
            NavigationLink {
                ProfileView(from: .challenges)
            } label: {
                Circle()
                    .frame(width: 36, height: 36)
                    .foregroundColor(Color.notYoCheese)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    @ViewBuilder
    var titleApp: some View {
        HStack {
            Text("Nama App")
                .modifier(TextModifier(color: .white, size: 34, weight: .medium))
            Spacer()
        }
        .padding(.leading)
    }
    
    @ViewBuilder
    var competitionButtons: some View {
        HStack {
            NavigationLink {
               JoinChallengeView()
            } label: {
                Text("Join a Competition")
                    .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                    .frame(width: 165, height: 37)
                    .background(Color.insignia)
                    .cornerRadius(6)
            }

            Spacer()
            NavigationLink {
               CreateChallengeView()
            } label: {
                Text("Create a Competition")
                    .modifier(TextModifier(color: .white, size: 14, weight: .medium))
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
