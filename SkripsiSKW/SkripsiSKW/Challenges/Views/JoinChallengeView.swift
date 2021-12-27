//
//  JoinChallengeView.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct JoinChallengeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var joinChallengeVM: JoinChallengeViewModel = JoinChallengeViewModel()
    
    var body: some View {
        ZStack {
            Color.sambucus.ignoresSafeArea()
            VStack(alignment: .center, spacing: 24) {
                if #available(iOS 14.0, *) {
                    VStack(spacing: 0) {
                        codeTextField
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                } else {
                    VStack(spacing: 0) {
                        codeTextField
                    }
                }
                
                Spacer()
                RoundedButton(title: "Continue") {
                    joinChallengeVM.joinChallenge()
                }
                .opacity(joinChallengeVM.canJoin ? 1.0 : 0.5)
                .disabled(!joinChallengeVM.canJoin)
                .alert(isPresented: $joinChallengeVM.alertPresented) {
                    Alert(title: Text(joinChallengeVM.getAlertData().title), message: Text(joinChallengeVM.getAlertData().message), dismissButton: .cancel(Text("Ok")))
                }
                Spacer(minLength: 300)
            }
            .padding(.top, 24)
            .navigationTitle("Join Competition")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                CustomToolbarTwoButtons(toolbarLeadingTitle: "Cancel", leadingAction: {
                    presentationMode.wrappedValue.dismiss()
                }, toolbarTrailingTitle: "") {
                    
                }
            }
        }
    }
}

extension JoinChallengeView {
    @ViewBuilder
    private var codeTextField: some View {
        if #available(iOS 15.0, *) {
            TextField("Enter Code", text: $joinChallengeVM.challengeCode, prompt: Text("Enter Code"))
                .multilineTextAlignment(.center)
                .modifier(TextFieldModifier(fontSize: 34, backgroundColor: Color.clear, textColor: Color.white, weight: .bold))
                .textInputAutocapitalization(.characters)
        } else {
            // Fallback on earlier versions
            TextField("Enter Code", text: $joinChallengeVM.challengeCode)
                .multilineTextAlignment(.center)
                .modifier(TextFieldModifier(fontSize: 34, backgroundColor: Color.clear, textColor: Color.white, weight: .bold))
                .autocapitalization(.allCharacters)
        }
        Text("Type the competition code you want to join")
            .modifier(TextModifier(color: Color.snowflake, size: 13, weight: .bold))
        
    }
}

struct JoinChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        JoinChallengeView()
    }
}
