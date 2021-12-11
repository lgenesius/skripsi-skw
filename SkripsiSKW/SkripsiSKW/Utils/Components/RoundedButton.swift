//
//  RoundedButton.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct RoundedButton: View {
    var title: String
    var action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(Font.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 49)
                .background(Color.insignia)
                .cornerRadius(15)
                .padding(.horizontal)
        }
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "Sign In") {
            
        }
    }
}
