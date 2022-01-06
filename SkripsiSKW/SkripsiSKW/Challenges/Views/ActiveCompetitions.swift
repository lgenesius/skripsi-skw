//
//  ActiveCompetitions.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 20/12/21.
//

import SwiftUI

struct ActiveCompetitions: View {
    @State private var isDropDown = true
    @StateObject var activeCompetitionVM: ActiveCompetitionListViewModel
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
                        ForEach(activeCompetitionVM.competitionListModel) { activeCompetitionVM in
                            NavigationLink {
                                CompetitionLeaderboard(activeCompetitionVM: activeCompetitionVM)
                            } label: {
                                ActiveCompetitionCard(activeCompetitionVM: activeCompetitionVM)
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            activeCompetitionVM.fetchData()
        })
        .padding(.horizontal)
        .padding(.top)
    }
}
