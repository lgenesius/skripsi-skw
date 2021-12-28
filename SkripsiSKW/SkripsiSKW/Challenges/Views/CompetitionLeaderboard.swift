//
//  CompetitionLeaderboard.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct CompetitionLeaderboard: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var competitionVM: CompetitionViewModel = CompetitionViewModel()
    
    var body: some View {
        ZStack {
            Color.sambucus.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                competitionPoint
                competitionRank
                Spacer(minLength: 120)
                competitionButtons
            }
            .padding(.top, 24)
            .navigationTitle("Competition Name")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.notYoCheese)
                            Text("Back")
                                .foregroundColor(.notYoCheese)
                        }
                    }
                }
            }
        }
    }
}

extension CompetitionLeaderboard {
    
    @ViewBuilder
    private var competitionPoint : some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("TOTAL POINTS (300 Max)")
                .modifier(TextModifier(color: Color.oldSilver, size: 14, weight: .regular))
            Text("245 Points")
                .modifier(TextModifier(color: Color.snowflake, size: 24, weight: .bold))
            ProgressBar(value: $competitionVM.dummyTotalPointPercentage, backgroundColor: Color.oldSilver, progressBarColor: Color.notYoCheese, height: CGFloat(15))
        }.padding()
    }
    
    @ViewBuilder
    private var competitionRank: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("YOUR RANK (out of \(competitionVM.getTotalParticipant()))")
                .modifier(TextModifier(color: Color.oldSilver, size: 14, weight: .regular))
            HStack {
                Text("1st Rank")
                    .modifier(TextModifier(color: Color.snowflake, size: 24, weight: .bold))
                Spacer()
                NavigationLink {
                    CompetitionLeaderboardDetail(competitionVM: competitionVM)
                } label: {
                    Text("See All")
                        .modifier(TextModifier(color: .notYoCheese, size: 14, weight: .regular))
                }
            }
            competitionLeaderboardList
        }.padding()
    }
    
    @ViewBuilder
    private var competitionLeaderboardList: some View {
        LeaderboardList(listOfData: $competitionVM.dummyData)
    }
    
    
    @ViewBuilder
    var competitionButtons: some View {
        GeometryReader { geo in
            HStack {
                NavigationLink {

                } label: {
                    Text("Invite Others")
                        .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                        .frame(width: geo.size.width * 0.48, height: 37)
                        .background(Color.insignia)
                        .cornerRadius(6)
                }

                Spacer()
                NavigationLink {

                } label: {
                    Text("Leave Competition")
                        .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                        .frame(width: geo.size.width * 0.48, height: 37)
                        .background(Color.insignia)
                        .cornerRadius(6)
                }
            }
        }.padding(.horizontal)
    }
}

struct CompetitionLeaderboard_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionLeaderboard()
    }
}
