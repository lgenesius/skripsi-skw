//
//  WorkoutRotationView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 25/12/21.
//

import SwiftUI

struct WorkoutRotationView: View {
    @Binding var isOrientationPresent: Bool
    var completion: (() -> Void)
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        VStack {
            Spacer()
            Text("Rotate your Phone Screen")
                .modifier(TextModifier(
                    color: .white,
                    size: 30,
                    weight: .bold)
                )
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Image("rotate-landscape")
                .frame(width: 110, height: 110)
            Spacer()
            Spacer()
            RoundedButton(title: "Done") {
                withAnimation {
                    isOrientationPresent = false
                }
                completion()
            }
            .allowsHitTesting(!orientation.isLandscape ? false: true)
            .opacity(!orientation.isLandscape ? 0.5: 1)
        }
        .padding()
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}
