//
//  ErrorMessage.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 18/12/21.
//

import SwiftUI

struct ErrorText: View {
    var errorMessage: String
    
    var body: some View {
        HStack {
            Text(errorMessage)
                .font(Font.system(size: 12))
                .foregroundColor(.red)
            Spacer()
        }
        .padding(.horizontal)
    }
}
