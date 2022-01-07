//
//  ProfileImageView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 07/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileImageView: View {
    var userId: String?
    @Binding var currentUser: User?
    
    var body: some View {
        if #available(iOS 15.0, *) {
            if !currentUser!.profileImageUrl.isEmpty {
                WebImage(url: URL(string: currentUser!.profileImageUrl))
                    .resizable()
                    .indicator(.activity)
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
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 110, height: 110)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.white)
                            .scaleEffect(2)
                            .opacity(userId == nil ? 1: 0)
                    }
            }
        } else {
            // Fallback on earlier versions
            if !currentUser!.profileImageUrl.isEmpty {
                WebImage(url: URL(string: currentUser!.profileImageUrl))
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .overlay(
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.white)
                            .scaleEffect(2)
                            .opacity(userId == nil ? 1: 0),
                        alignment: .bottomTrailing
                    )
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.white)
                    .overlay(
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.white)
                            .scaleEffect(2)
                            .opacity(userId == nil ? 1: 0),
                        alignment: .bottomTrailing
                    )
            }
        }
    }
}
