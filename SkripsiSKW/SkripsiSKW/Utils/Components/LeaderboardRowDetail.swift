//
//  LeaderboardRowDetail.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 11/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct LeaderboardRowDetail: View {
    @EnvironmentObject var sessionVM: SessionViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var badgesViewModel : BadgeListViewModel = BadgeListViewModel()
    @StateObject var leaderbordVM: LeaderboardRowDetailViewModel
    var rank: Int = 0
    
    private let gridLayout = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var userID: String
    
    var body: some View {
        mainBody
            .onAppear(perform: {
                leaderbordVM.fetchUserDetail { Bool in
                    badgesViewModel.fetchUserDetailBadges(userId: userID)
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.notYoCheese)
                            Text("back")
                                .foregroundColor(.notYoCheese)
                        }
                    }
                }
            }
    }
    
    @ViewBuilder
    var mainBody: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    headerProfile
                    top3Badges
                    LatestBadge(badgesViewModel: badgesViewModel.topThree(), badgesListVM: badgesViewModel)
                    ListOfBadge(badgesViewModel: badgesViewModel.userBadgeListViewModel, badgesListVM: badgesViewModel)
                }
            }

        }
    }
    
    @ViewBuilder
    var headerProfile: some View {
        HStack(alignment: .center) {
            ProfileImageView(currentUser: $leaderbordVM.relatedUser, userId: leaderbordVM.userId, width: 110, height: 110)
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text(leaderbordVM.relatedUser?.name ?? "")
                    .modifier(TextModifier(
                        color: .white,
                        size: 24,
                        weight: .bold
                    ))
                    .lineLimit(1)
                Text("\(leaderbordVM.relatedUser?.totalPoint ?? 0) Points Gained" )
                    .modifier(TextModifier(
                        color: .notYoCheese,
                        size: 18,
                        weight: .medium
                    ))
                
                HStack {
                        if #available(iOS 15.0, *) {
                            Circle()
                                .fill(Color.bubonicBrown)
                                .frame(width: 34, height: 34)
                                .overlay {
                                    Text("2nd")
                                        .modifier(TextModifier(
                                            color: .white,
                                            size: 12,
                                            weight: .medium
                                        ))
                                }
                        } else {
                            // Fallback on earlier versions
                            Circle()
                                .fill(Color.bubonicBrown)
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Text("2nd")
                                        .modifier(TextModifier(
                                            color: .white,
                                            size: 12,
                                            weight: .medium
                                        ))
                                )
                        }
                    
                    Text("8 Badges")
                        .modifier(TextModifier(
                            color: .white,
                            size: 18,
                            weight: .bold
                        ))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.blueDepths)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    var top3Badges: some View {
        VStack(alignment: .leading) {
            Text("Top 3 Badges")
                .modifier(TextModifier(
                    color: .white,
                    size: 24,
                    weight: .medium
                ))
            
            HStack(spacing: 15) {
                ForEach(0..<3) { _ in
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 13)
                            .fill(Color.blueDepths)
                            .frame(maxWidth: .infinity, minHeight: 125)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
