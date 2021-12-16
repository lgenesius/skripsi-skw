//
//  ContentView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionVM: SessionViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.sambucus
                    .ignoresSafeArea()
                
                if sessionVM.isLoading == false {
                    if sessionVM.authUser != nil {
                        ChallengesView()
                    } else {
                        SignInView()
                    }
                }
            }
        }
        .onAppear {
            sessionVM.listen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
