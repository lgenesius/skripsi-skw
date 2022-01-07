//
//  ProfileView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 22/12/21.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var sessionVM: SessionViewModel
    @ObservedObject var badgesViewModel : BadgeListViewModel
    var navigationTitle: NavigationTitle
    var userId: String?
    
    @State private var presentActionSheet = false
    @State private var presentLogoutAlert = false
    @State private var presentPhotoSheet = false
    @State private var presentCheckPhoto = false
    
    @State private var imageData = Data()
    
    private let gridLayout = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    init(from navigationTitle: NavigationTitle, uId: String? = nil, badgesViewModel: BadgeListViewModel) {
        self.navigationTitle = navigationTitle
        
        if let uId = uId {
            userId = uId
        }
        self.badgesViewModel = badgesViewModel
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            mainBody
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
                                Text(navigationTitle.title)
                                    .foregroundColor(.notYoCheese)
                            }
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            presentLogoutAlert = true
                        } label: {
                            Text("Logout")
                                .foregroundColor(.notYoCheese)
                        }
                    }
                }
                .alert(
                    "Logout",
                    isPresented: $presentLogoutAlert,
                    actions: {
                        Button("Cancel", role: .cancel, action: {})
                        Button("Logout") {
                            sessionVM.logout()
                        }
                    },
                    message: {
                        Text("Are you sure you want to Logout?")
                    })
                .confirmationDialog("Select Action", isPresented: $presentActionSheet, titleVisibility: .visible) {
                    Button {
                        presentPhotoSheet = true
                    } label: {
                        Text("Upload Picture")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Remove Picture")
                    }
                }
                .sheet(isPresented: $presentPhotoSheet) {
                    PhotoPicker(isPresented: $presentPhotoSheet, data: $imageData) { status in
                        showCheckPhoto(status: status)
                    }
                }
        } else {
            // Fallback on earlier versions
            mainBody
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text(""))
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.notYoCheese)
                                Text(navigationTitle.title)
                                    .foregroundColor(.notYoCheese)
                            }
                        }),
                    trailing:
                        Button(action: {
                            presentLogoutAlert = true
                        }, label: {
                            Text("Logout")
                                .foregroundColor(.notYoCheese)
                        })
                )
                .alert(isPresented: $presentLogoutAlert) {
                    Alert(
                        title: Text("Logout"),
                        message: Text("Are you sure you want to Logout?"),
                        primaryButton: .cancel(),
                        secondaryButton: .default(Text("Logout"), action: {
                            sessionVM.logout()
                        })
                    )
                }
                .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(
                        title: Text("Select Action"),
                        buttons: [
                            .default(Text("Upload Picture"), action: {
                                presentPhotoSheet = true
                            }),
                            .default(Text("Remove Picture"), action: {
                                
                            }),
                            .cancel()
                        ]
                    )
                }
                .sheet(isPresented: $presentPhotoSheet) {
                    PhotoPicker(isPresented: $presentPhotoSheet, data: $imageData) { status in
                        showCheckPhoto(status: status)
                    }
                }
        }
    }
    
    private func showCheckPhoto(status: Bool) {
        guard status else { return }
        withAnimation {
            presentCheckPhoto = true
        }
    }
}

extension ProfileView {
    
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
            Rectangle().fill(Color.black).opacity(badgesViewModel.showBadgeDetail ? 0.5 : 0).onTapGesture {
                badgesViewModel.showBadgeDetail.toggle()
            }
            BadgeAdd(badgesViewModel: badgesViewModel.selectedBadgeViewModel, badgesListVM: badgesViewModel).opacity(badgesViewModel.showBadgeDetail ? 1 : 0)
            PhotoCheckView(isPresented: $presentCheckPhoto, imageData: $imageData)
        }
    }
    
    @ViewBuilder
    var headerProfile: some View {
        HStack(alignment: .center) {
            Button {
                presentActionSheet = true
            } label: {
                if #available(iOS 15.0, *) {
                    Image("dummy")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .overlay(alignment: .bottomTrailing) {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.white)
                                .scaleEffect(2)
                                .opacity(userId == nil ? 1: 0)
                        }
                } else {
                    // Fallback on earlier versions
                    Image("dummy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .overlay(
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.white)
                                .scaleEffect(2)
                                .opacity(userId == nil ? 1: 0),
                            alignment: .bottomTrailing
                        )
                }
            }
            .allowsHitTesting(userId == nil ? true: false)
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text("Kevin Leon Luis Genesius")
                    .modifier(TextModifier(
                        color: .white,
                        size: 24,
                        weight: .bold
                    ))
                    .lineLimit(1)
                Text(userId == nil ? "3260 Points Gained": "231 Points")
                    .modifier(TextModifier(
                        color: .notYoCheese,
                        size: 18,
                        weight: .medium
                    ))
                
                HStack {
                    if userId != nil {
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

