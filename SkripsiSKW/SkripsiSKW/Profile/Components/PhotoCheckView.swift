//
//  PhotoCheckView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 07/01/22.
//

import SwiftUI

struct PhotoCheckView: View {
    @EnvironmentObject var sessionVM: SessionViewModel
    @Binding var isPresented: Bool
    @Binding var imageData: Data
    @Binding var currentUser: User?
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: Screen.width / 2, height: Screen.width / 2)
                        .clipShape(Circle())
                    
                    Text("Do you want to change?")
                        .foregroundColor(.white)
                        .padding(.top, 5)
                    
                    HStack(spacing: 20) {
                        Button {
                            withAnimation {
                                isPresented = false
                                imageData = Data()
                            }
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.insignia)
                                .cornerRadius(10)
                        }

                        Button {
                            updateImageAndData()
                        } label: {
                            Text("Yes")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.insignia)
                                .cornerRadius(10)
                        }

                    }
                    Spacer()
                }
            }
            
        }
    }
    
    private func updateImageAndData() {
        guard let currentUser = currentUser else { return }
        if currentUser.profileImageUrl.isEmpty {
            PhotoProfileManager.shared.savePhoto(userId: currentUser.uid, imageData: imageData) { metaImageUrl, error2 in
                guard error2 == nil else { return }
                sessionVM.authUser?.profileImageUrl = metaImageUrl
                self.currentUser = sessionVM.authUser
                AuthManager.shared.updateUser(user: self.currentUser!) { _ in
                    isPresented = false
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
                        isPresented = false
                    }
                }
            }
        }
    }
}
