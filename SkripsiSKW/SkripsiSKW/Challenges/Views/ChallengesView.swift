//
//  ChallengesView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import SwiftUI

struct ChallengesView: View {
    @EnvironmentObject var sessionVM: SessionViewModel
    @StateObject var badgesViewModel = AllBadgeViewModel()
    
    @State private var isAlertPresent = false
    @State private var alertIdentifier: AlertIdentifier = .caution
    @State private var selectedExercises: WorkoutType = .squat
    
    @State private var isExerciseLinkActivate = false
    
    var body: some View {
        if #available(iOS 15.0, *) {
            mainBody
                .alert(
                    alertIdentifier.title,
                    isPresented: $isAlertPresent
                ) {
                    Button(alertIdentifier.primaryButtonString, role: .cancel, action: {})
                    Button(alertIdentifier.secondaryButtonString) {
                        secondaryAlertAction()
                    }
                } message: {
                    Text(alertIdentifier.message)
                }
        } else {
            // Fallback on earlier versions
            mainBody
                .alert(isPresented: $isAlertPresent) {
                    Alert(
                        title: Text(alertIdentifier.title),
                        message: Text(alertIdentifier.message),
                        primaryButton: .cancel(),
                        secondaryButton: .default(
                            Text(alertIdentifier.secondaryButtonString),
                            action: {
                                secondaryAlertAction()
                            })
                    )
                }
        }
        
    }
    
    private func requestCameraAuth() {
        let cameraAuthStatus = CameraAuthorizationManager.getCameraAuthorizationStatus()
        
        if cameraAuthStatus == .notRequested {
            CameraAuthorizationManager.requestCameraAuthorization { _ in }
        }
    }
    
    private func secondaryAlertAction() {
        switch alertIdentifier {
        case .caution:
            isExerciseLinkActivate = true
        case .openSettings:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
}

extension ChallengesView {
    
    @ViewBuilder
    var mainBody: some View {
        VStack {
            dateAndPhotoProfile
            
            titleApp
            
            ScrollView {
                LazyVStack {
                    competitionButtons
                    
                    DailyChallengesView(dailyChallengeListVM: DailyChallengeListViewModel())
                    
                    NavigationLink(isActive: $isExerciseLinkActivate) {
                        WorkoutNavigation(workout: selectedExercises)
                    } label: {
                        EmptyView()
                    }
                    
                    ExercisesList(isAlertPresent: $isAlertPresent, alertIdentifier: $alertIdentifier, selectedExercises: $selectedExercises)
                    
                    ActiveCompetitions(activeCompetitionVM: ActiveCompetitionListViewModel())
                    
                    BadgesView()
                }
                
                Spacer()
            }
            Rectangle().background(Color.black).opacity(badgesViewModel.showBadgeDetail ? 0.7 : 0).onTapGesture {
                badgesViewModel.showBadgeDetail.toggle()
            }
            BadgeAdd(isShown: badgesViewModel.showBadgeDetail).opacity(badgesViewModel.showBadgeDetail ? 1 : 0)
        }
        
        .navigationBarHidden(true)
        .onAppear {
            requestCameraAuth()
        }
    }
    
    @ViewBuilder
    var dateAndPhotoProfile: some View {
        HStack {
            Text(DateManager.shared.getCurrentDayAndDateLongVersion())
                .modifier(TextModifier(color: .notYoCheese, size: 17, weight: .regular))
            Spacer()
            NavigationLink {
                ProfileView( from: .challenges, badgesViewModel: badgesViewModel)
            } label: {
                Circle()
                    .frame(width: 36, height: 36)
                    .foregroundColor(Color.notYoCheese)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    @ViewBuilder
    var titleApp: some View {
        HStack {
            Text("Nama App")
                .modifier(TextModifier(color: .white, size: 34, weight: .medium))
            Spacer()
        }
        .padding(.leading)
    }
    
    @ViewBuilder
    var competitionButtons: some View {
        HStack {
            NavigationLink {
               JoinChallengeView()
            } label: {
                Text("Join a Competition")
                    .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                    .frame(width: 165, height: 37)
                    .background(Color.insignia)
                    .cornerRadius(6)
            }

            Spacer()
            NavigationLink {
               CreateChallengeView()
            } label: {
                Text("Create a Competition")
                    .modifier(TextModifier(color: .white, size: 14, weight: .medium))
                    .frame(width: 165, height: 37)
                    .background(Color.insignia)
                    .cornerRadius(6)
            }
        }
        .padding(.horizontal)
    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
