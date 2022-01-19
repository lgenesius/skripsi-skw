//
//  ChallengesView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import SwiftUI

struct ChallengesView: View {
    @EnvironmentObject var sessionVM: SessionViewModel
    @StateObject var badgesViewModel = BadgeListViewModel()
    @StateObject var activeCompetViewModel: ActiveCompetitionListViewModel
    
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
        ZStack{
            VStack {
                dateAndPhotoProfile
                
                titleApp
                
                ScrollView {
                    LazyVStack {
                        competitionButtons
                        
                        DailyChallengesView()
                        
                        NavigationLink(isActive: $isExerciseLinkActivate) {
                            WorkoutNavigation(workout: selectedExercises, activeCompetitionVM: activeCompetViewModel)
                        } label: {
                            EmptyView()
                        }
                        
                        ExercisesList(isAlertPresent: $isAlertPresent, alertIdentifier: $alertIdentifier, selectedExercises: $selectedExercises)
                        
                        ActiveCompetitions(activeCompetitionListVM: activeCompetViewModel)
                        
                        BadgesView(badgesListVM: badgesViewModel)
                    }
                    
                    Spacer()
                }
                
            }
            Rectangle().fill(Color.black).ignoresSafeArea().opacity(badgesViewModel.showBadgeDetail ? 0.7 : 0).onTapGesture {
                badgesViewModel.showBadgeDetail.toggle()
                
            }
            BadgeAdd(badgesViewModel: badgesViewModel.selectedBadgeViewModel, badgesListVM: badgesViewModel).opacity(badgesViewModel.showBadgeDetail ? 1 : 0)
        }
        
        
        .navigationBarHidden(true)
        .onAppear {
            requestCameraAuth()
            badgesViewModel.fetchUserBadges(sessionVM: sessionVM)
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
                ProfileImageView(currentUser: $sessionVM.authUser, userId: sessionVM.authUser?.uid, width: 36, height: 36)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    @ViewBuilder
    var titleApp: some View {
        HStack {
            Text("PoseFit")
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
