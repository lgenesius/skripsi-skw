//
//  CompetitionLeaderboardDetail.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct CompetitionLeaderboardDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var competitionVM: CompetitionViewModel
    
    var body: some View {
        ZStack {
            Color.sambucus.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                leaderboardList
                leaderboardFooter
                Spacer()
            }
            .padding(24)
            .navigationTitle("Competition Name")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        competitionVM.reset()
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
            .onAppear {
                competitionVM.initiateFirstTen()
            }
        }
        
    }
}

extension CompetitionLeaderboardDetail {
    @ViewBuilder
    private var leaderboardList: some View {
        Text("Leaderboard (\(competitionVM.getTotalParticipant()) participants)")
            .modifier(TextModifier(color: Color.snowflake, size: 18, weight: .bold))
        LeaderboardList(listOfData: $competitionVM.dummyData, incrementIndex: competitionVM.getListIncrement())
    }
    
    @ViewBuilder
    private var leaderboardFooter: some View {
        HStack(alignment: .bottom) {
            Spacer()
            Text("Page \(competitionVM.getPagination().currentPage) of \(competitionVM.getPagination().totalPage)")
                .modifier(TextModifier(color: Color.oldSilver, size: 14, weight: .regular))
            Spacer()
        }.overlay(
            HStack {
                prevButton
                    .opacity(competitionVM.prevButton ? 1.0 : 0)
                Spacer()
                nextButton
                    .opacity(competitionVM.nextButton ? 1.0 : 0)
            }
        )
    }
    
    @ViewBuilder
    private var nextButton: some View {
        Button {
            withAnimation {
                competitionVM.next()
            }
        } label: {
            Text("Next")
                .font(Font.system(size: 14))
                .foregroundColor(.white)
                .frame(width: 65, height: 24)
                .background(Color.insignia)
                .cornerRadius(5)
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var prevButton: some View {
        Button {
            withAnimation {
                competitionVM.prev()
            }
        } label: {
            Text("Prev")
                .font(Font.system(size: 14))
                .foregroundColor(.white)
                .frame(width: 65, height: 24)
                .background(Color.insignia)
                .cornerRadius(5)
                .padding(.horizontal)
        }
    }
}

struct CompetitionLeaderboardDetail_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionLeaderboardDetail(competitionVM: CompetitionViewModel())
    }
}
