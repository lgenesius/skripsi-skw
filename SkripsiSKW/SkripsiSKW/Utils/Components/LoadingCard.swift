//
//  LoadingCard.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 18/12/21.
//

import SwiftUI

struct LoadingCard: View {
    let isLoading: Bool
    let message: String
    
    var body: some View {
        if isLoading {
            Rectangle()
                .fill(Color.notYoCheese)
                .frame(width: 200, height: 150)
                .cornerRadius(20)
                .overlay(
                    VStack(alignment: .center, spacing: 15) {
                        ActivityIndicator()
                        
                        Text(message)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                )
        }
    }
}

struct LoadingCard_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCard(isLoading: true, message: "Sign In..")
    }
}
