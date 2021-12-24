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
            
            VStack(alignment: .leading, spacing: 24) {
                competitionPoint
                Spacer()
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
        VStack(alignment: .leading) {
            Text("TOTAL POINTS (300 Max)")
                .modifier(TextModifier(color: Color.oldSilver, size: 14, weight: .regular))
            Text("245 Points")
                .modifier(TextModifier(color: Color.snowflake, size: 24, weight: .bold))
            ProgressBar(value: $competitionVM.dummyTotalPointPercentage).frame(height: 20)
        }.padding()
    }
}

struct CompetitionLeaderboard_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionLeaderboard()
    }
}
