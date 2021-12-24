//
//  JoinChallengeViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import Foundation
import Combine

enum JoinChallengeEnum {
    case valid
    case moreThanTwo
    case insideTheCompetition
    case inValid
    
    fileprivate func getAlertMessage() -> (title: String, message: String) {
        switch self {
            case .valid:
                return ("Valid", "Valid")
            case .moreThanTwo:
                return ("Limit", "You’ve already joined 2 Competitions")
            case .insideTheCompetition:
                return ("Same Competition", "You are already inside the competition")
            case .inValid:
                return ("Invalid", "Invalid Bro")
        }
    }
}

class JoinChallengeViewModel: ObservableObject {
    @Published var challengeCode: String = ""
    @Published var canJoin: Bool = false
    @Published var challengeValidatity: JoinChallengeEnum = .inValid
    @Published private var alertMessage: String = ""
    @Published private var alertTitle: String = ""
    @Published var alertPresented: Bool = false
    
    private var subscription: Set<AnyCancellable> = []
    
    init() {
        addTextFieldSubscriber()
    }
    
    deinit {
        subscription.removeAll()
    }
    
    func getAlertData() -> (title: String, message: String) {
        return (title: self.alertTitle, message: self.alertMessage)
    }
    
    func joinChallenge() {
        //TODO: Kasi Logic buat check kode competition lalu setup Enum Challenge Validity based on respon yang diberikan
        self.challengeValidatity = .moreThanTwo
        self.alertMessage = self.challengeValidatity.getAlertMessage().message
        self.alertTitle = self.challengeValidatity.getAlertMessage().title
        self.alertPresented.toggle()
    }
}

extension JoinChallengeViewModel {
    private func addTextFieldSubscriber() {
        $challengeCode.debounce(for: 0.2, scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 5 || text.count < 1{ return false }
                else if text.count <= 5 && text.count > 0 { return true }
                return false
            }
            .sink { [weak self] canButtonJoin in
                guard let self = self else { return }
                self.canJoin = canButtonJoin
            }
            .store(in: &subscription)
    }
}
