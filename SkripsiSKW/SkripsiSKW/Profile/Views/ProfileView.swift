//
//  ProfileView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 22/12/21.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var sessionVM: SessionViewModel
    
    var navigationTitle: NavigationTitle
    
    @State private var presentLogoutAlert = false
    
    init(from navigationTitle: NavigationTitle) {
        self.navigationTitle = navigationTitle
    }
    
    var body: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            
        }
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
                    presentLogoutAlert = true
                } label: {
                    Text("Logout")
                        .foregroundColor(.notYoCheese)
                }
            }
        }
        .alert(isPresented: $presentLogoutAlert) {
            Alert(
                title: Text("Logout"),
                message: Text("Are you sure you want to Logout?"),
                primaryButton: .cancel(),
                secondaryButton: .default(Text("Logout"), action: {
                    sessionVM.logout()
                })
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(from: .challenges)
    }
}
