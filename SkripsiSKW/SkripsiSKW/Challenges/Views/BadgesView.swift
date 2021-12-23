//
//  BadgesView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 21/12/21.
//

import SwiftUI

struct BadgesView: View {
    @State private var roundedRect: CGRect = .zero
    
    var body: some View {
        VStack {
            HStack {
                Text("Badges")
                    .modifier(TextModifier(color: .white, size: 24, weight: .medium))
                Spacer()
                NavigationLink {
                    Text("List of All Badges")
                } label: {
                    Text("Show More")
                        .modifier(TextModifier(color: .notYoCheese, size: 14, weight: .regular))
                }
            }
            
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color.midnightExpress)
                    .frame(maxWidth: .infinity)
                    .frame(height: 154)
                    .background(GeometryGetter(rect: $roundedRect))
                    .overlay {
                        HStack(spacing: 15) {
                            ForEach(0..<3) { _ in
                                RoundedRectangle(cornerRadius: 13)
                                    .fill(Color.blueDepths)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                    }
            } else {
                // Fallback on earlier versions
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color.midnightExpress)
                    .frame(maxWidth: .infinity)
                    .frame(height: 154)
                    .background(GeometryGetter(rect: $roundedRect))
                    .overlay(
                        HStack(spacing: 15) {
                            ForEach(0..<3) { _ in
                                RoundedRectangle(cornerRadius: 13)
                                    .fill(Color.blueDepths)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                    )
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct BadgesView_Previews: PreviewProvider {
    static var previews: some View {
        BadgesView()
    }
}
