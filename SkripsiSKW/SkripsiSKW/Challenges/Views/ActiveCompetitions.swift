//
//  ActiveCompetitions.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 20/12/21.
//

import SwiftUI

struct ActiveCompetitions: View {
    @State private var isDropDown = true
    @StateObject var activeCompetitionListVM: ActiveCompetitionListViewModel
    @EnvironmentObject var sessionVM: SessionViewModel
    var body: some View {
        VStack {
            HStack {
                Text("My Active Competitions")
                    .modifier(TextModifier(color: .white, size: 24, weight: .medium))
                Spacer()
                Button {
                    withAnimation {
                        isDropDown.toggle()
                    }
                } label: {
                    Image(systemName: isDropDown ? "chevron.down": "chevron.up")
                        .foregroundColor(.notYoCheese)
                        .frame(width: 20, height: 20)
                }
            }
            
            
            if isDropDown {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(activeCompetitionListVM.competitionListModel) { activeCompetitionVM in
                            NavigationLink {
//                                BadgeService.addBadge(badge: Badge(name: "", description: "", image: "", goal: 0, identifier: .squat)) {
//
//                                } onError: { errorMessage in
//
//                                }
                                CompetitionLeaderboard(activeCompetitionVM: activeCompetitionVM)
//                                    .onAppear {
//                                        activeCompetitionListVM.updateAllData(by: 30)
//                                    }
                            } label: {
                                ActiveCompetitionCard(activeCompetitionVM: activeCompetitionVM)
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            activeCompetitionListVM.fetchData()
        })
        .padding(.horizontal)
        .padding(.top)
    }
}
