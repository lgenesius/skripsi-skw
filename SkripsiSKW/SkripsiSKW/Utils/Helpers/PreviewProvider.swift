//
//  PreviewProdiver.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let challenge = DailyChallenge(challengeName: "", challengeDescription: "", challengeCompletion: 0, challengeGoal: 0, challengeIdentifier: "")
    
    let dailyChallengeVM = DailyChallengeViewModel(challenge: DailyChallenge(challengeName: "", challengeDescription: "", challengeCompletion: 0, challengeGoal: 0, challengeIdentifier: ""))
    
    let activeCompetitionVM = ActiveCompetitionViewModel(
        competition: Competition(
            id: "123",
            startDateEvent: Date().shortDate,
            endDateEvent: Date().shortDate,
            competitionName: "Competition Name",
            competitionDescription: "Competition Description",
            users: [],
            competitionCode: "123",
            isRunning: true), userId: "")
    
    let userBadgeVM = BadgeViewModel(userBadge: UserBadge(competitionId: "", name: "", description: "", image: "", goal: 123, progress: 0, recievedDate: Date(), isHighlighted: false, identifier: ""))
}
