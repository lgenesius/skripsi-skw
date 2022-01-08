//
//  ProfileImageView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 07/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileImageView: View {
    @Binding var currentUser: User?
    var userId: String?
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if #available(iOS 15.0, *) {
            if !currentUser!.profileImageUrl.isEmpty {
                WebImage(url: URL(string: currentUser!.profileImageUrl))
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(width: width, height: height)
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
                    .frame(width: width, height: height)
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
                    .frame(width: width, height: height)
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
                    .frame(width: width, height: height)
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
