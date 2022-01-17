//
//  ProfileView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 22/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

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
    @State private var isLoading = false
    
    @State private var imageData = Data()
    @State private var currentUser: User?
    
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
                            sessionVM.logout()
                        } label: {
                            Text("Logout")
                                .foregroundColor(.notYoCheese)
                        }
                    }
                }
                .onAppear(perform: {
                    isLoading = true
                    if let uId = userId {
                        AuthManager.shared.getUser(userId: uId) { user, error in
                            self.isLoading = false
                            guard error != nil else { return }
                            guard let user = user else { return }
                            self.currentUser = user
                        }
                    } else {
                        isLoading = false
                        currentUser = sessionVM.authUser
                    }
                })
                .confirmationDialog("Select Action", isPresented: $presentActionSheet, titleVisibility: .visible) {
                    Button {
                        presentPhotoSheet = true
                    } label: {
                        Text("Upload Picture")
                    }
                    
                    Button {
                        deleteImageAndUpdate()
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
                            sessionVM.logout()
                        }, label: {
                            Text("Logout")
                                .foregroundColor(.notYoCheese)
                        })
                )
                .onAppear(perform: {
                    isLoading = true
                    if let uId = userId {
                        AuthManager.shared.getUser(userId: uId) { user, error in
                            self.isLoading = false
                            guard error != nil else { return }
                            guard let user = user else { return }
                            self.currentUser = user
                        }
                    } else {
                        isLoading = false
                        currentUser = sessionVM.authUser
                    }
                })
                .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(
                        title: Text("Select Action"),
                        buttons: [
                            .default(Text("Upload Picture"), action: {
                                presentPhotoSheet = true
                            }),
                            .default(Text("Remove Picture"), action: {
                                deleteImageAndUpdate()
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
    
    private func updateImageAndData() {
        guard let currentUser = currentUser else { return }
        isLoading = true
        if currentUser.profileImageUrl.isEmpty {
            PhotoProfileManager.shared.savePhoto(userId: currentUser.uid, imageData: imageData) { metaImageUrl, error2 in
                guard error2 == nil else { return }
                sessionVM.authUser?.profileImageUrl = metaImageUrl
                self.currentUser = sessionVM.authUser
                AuthManager.shared.updateUser(user: self.currentUser!) { _ in
                    presentCheckPhoto = false
                    isLoading = false
                }
            }
        } else {
            PhotoProfileManager.shared.deletePhoto(userId: currentUser.uid) { error in
                guard error == nil else { return }
                PhotoProfileManager.shared.savePhoto(userId: currentUser.uid, imageData: imageData) { metaImageUrl, error2 in
                    guard error2 == nil else { return }
                    sessionVM.authUser?.profileImageUrl = metaImageUrl
                    self.currentUser = sessionVM.authUser
                    AuthManager.shared.updateUser(user: self.currentUser!) { _ in
                        presentCheckPhoto = false
                        isLoading = false
                    }
                }
            }
        }
    }
    
    private func deleteImageAndUpdate() {
        guard let currentUser = currentUser else { return }
        isLoading = true
        PhotoProfileManager.shared.deletePhoto(userId: currentUser.uid) { error in
            guard error == nil else { return }
            sessionVM.authUser?.profileImageUrl = ""
            self.currentUser = sessionVM.authUser
            AuthManager.shared.updateUser(user: self.currentUser!) { _ in
                isLoading = false
            }
        }
    }
}

extension ProfileView {
    
    @ViewBuilder
    var mainBody: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            if currentUser != nil {
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
                PhotoCheckView(isPresented: $presentCheckPhoto, isLoading: $isLoading, imageData: $imageData) { status in
                    if status {
                        updateImageAndData()
                    } else {
                        withAnimation {
                            presentCheckPhoto = false
                            imageData = Data()
                        }
                    }
                }
                LoadingCard(isLoading: isLoading, message: "Changing Image...")
            }
        }
        .onAppear {
            badgesViewModel.fetchUserBadges(sessionVM: sessionVM)
        }
    }
    
    @ViewBuilder
    var headerProfile: some View {
        HStack(alignment: .center) {
            Button {
                presentActionSheet = true
            } label: {
                ProfileImageView(currentUser: $currentUser, userId: userId, width: 110, height: 110)
            }
            .allowsHitTesting(userId == nil ? true: false)
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text(currentUser!.name)
                    .modifier(TextModifier(
                        color: .white,
                        size: 24,
                        weight: .bold
                    ))
                    .lineLimit(1)
                Text(userId == nil ? "\(currentUser!.totalPoint) Points Gained": "231 Points")
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
                ForEach(badgesViewModel.topThree()) { badgeVM in
                                    BadgeItem(badgeViewModel: badgeVM) .onTapGesture {
                                        badgesViewModel.selectBadgeViewModel(badgeVM: badgeVM)
                                        badgesViewModel.showBadgeDetail.toggle()
                                    }
            }
        }
        .padding(.horizontal)
    }
    }
}

