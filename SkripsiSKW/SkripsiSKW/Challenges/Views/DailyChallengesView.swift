//
//  DailyChallengesView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 20/12/21.
//

import SwiftUI

struct DailyChallengesView: View {
    @State private var isDropDown = true
    @ObservedObject var dailyChallengeListVM: DailyChallengeListViewModel
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Today's Challenges")
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
                VStack {
                ForEach($dailyChallengeListVM.dailyChallengeListModel) { $dailyChallengeVM in
                    VStack {
                        DailyChallengeCard(dailyChallengeVM:
                                            dailyChallengeVM )
                            .onTapGesture {
                                withAnimation {
                                    dailyChallengeListVM.selectBadgeViewModel(dailyChallengeVM: dailyChallengeVM)
                                    
                                    dailyChallengeListVM.showDailyChallengeDetail.toggle()
                                }
                            }
                    }
                }
                }
            }
        }
        .onAppear(perform: {
            dailyChallengeListVM.fetchData()
        })
        .padding(.horizontal)
        .padding(.top)
    }
}

struct DailyChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengesView(dailyChallengeListVM: DailyChallengeListViewModel())
    }
}
