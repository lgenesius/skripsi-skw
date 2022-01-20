//
//  CompetitionLeaderboard.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct CompetitionLeaderboard: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var sessionVM: SessionViewModel
    @State private var willLeave: Bool = false
    @State private var presentLoading: Bool = false
    
    @ObservedObject var activeCompetitionVM: ActiveCompetitionViewModel
    
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
            .navigationTitle(activeCompetitionVM.competition.competitionName)
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
            LoadingCard(isLoading: presentLoading, message: "Leaving Competition")
        }
        .onAppear {
            activeCompetitionVM.setData(userData: activeCompetitionVM.allUsers, userID: sessionVM.authUser?.uid ?? "")
        }
        .alert(isPresented: $willLeave) {
            Alert(
              title: Text("Leaving Competition"),
              message: Text("Are you sure you wanted to leave? All your point and ranking will be removed once you leave."),
              primaryButton: .destructive(Text("Cancel")),
              secondaryButton: .default(Text("Leave"), action: {
                  activeCompetitionVM.leaveCompetition(competitionId: activeCompetitionVM.id)
                  self.presentLoading = true
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      self.presentLoading = false
                      presentationMode.wrappedValue.dismiss()
                  }
              })
            )
        }   
    }
}

extension CompetitionLeaderboard {
    
    private func actionSheet() {
        let string = "Hi, dari aplikasi PoseFit! Ayo join challengeku, masukkan kode \(activeCompetitionVM.competition.competitionCode) untuk mengikuti Challenge: \(activeCompetitionVM.competition.competitionName) yang akan segera dimulai pada tanggal \(activeCompetitionVM.competition.startDateEvent)"
        let av = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    @ViewBuilder
    private var competitionPoint : some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("TOTAL POINTS (300 Max)")
                .modifier(TextModifier(color: Color.oldSilver, size: 14, weight: .regular))
            Text("\(activeCompetitionVM.dummyTotalPoint) Points")
                .modifier(TextModifier(color: Color.snowflake, size: 24, weight: .bold))
            ProgressBar(value: $activeCompetitionVM.dummyTotalPointPercentage, backgroundColor: Color.oldSilver, progressBarColor: Color.notYoCheese, height: CGFloat(15))
        }.padding()
    }
    
    @ViewBuilder
    private var competitionRank: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("YOUR RANK (out of \(activeCompetitionVM.getTotalParticipant()) Participants)")
                .modifier(TextModifier(color: Color.oldSilver, size: 14, weight: .regular))
            HStack {
                Text("\(activeCompetitionVM.userRanking) Rank")
                    .modifier(TextModifier(color: Color.snowflake, size: 24, weight: .bold))
                Spacer()
                NavigationLink {
                    CompetitionLeaderboardDetail(competitionVM: activeCompetitionVM
                    )
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
        LeaderboardList(listOfData: $activeCompetitionVM.allUsers)
    }
    
    
    @ViewBuilder
    var competitionButtons: some View {
        GeometryReader { geo in
            HStack {
                Button {
                    actionSheet()
                } label: {
                    Text("Invite Others")
                        .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                        .frame(width: geo.size.width * 0.48, height: 37)
                        .background(Color.insignia)
                        .cornerRadius(6)
                }

                Spacer()
                Button {
                    self.willLeave.toggle()
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
