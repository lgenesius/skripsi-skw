//
//  JoinChallengeViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import Foundation
import Combine

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
    
    func joinChallenge(completion: @escaping (JoinChallengeEnum) -> Void) {
        //TODO: Kasi Logic buat check kode competition lalu setup Enum Challenge Validity based on respon yang diberikan
        CompetitionService.JoinCompetition(self.challengeCode) { canJoin, error in
            self.challengeValidatity = canJoin
            self.alertMessage = self.challengeValidatity.getAlertMessage().message
            self.alertTitle = self.challengeValidatity.getAlertMessage().title
            self.alertPresented = true
            completion(canJoin)
        }
    }
}

extension JoinChallengeViewModel {
    private func addTextFieldSubscriber() {
        $challengeCode.debounce(for: 0.2, scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 5 || text.count < 1 { return false }
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
