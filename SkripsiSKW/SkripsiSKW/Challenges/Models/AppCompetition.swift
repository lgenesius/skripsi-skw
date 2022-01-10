//
//  AppCompetition.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Foundation
import FirebaseFirestoreSwift

struct AppCompetition {
    @DocumentID var id: String? = UUID().uuidString
    var startDateEvent: String
    var endDateEvent: String
    
    var competitionName: String
    var competitionDescription: String
    var users: [CompetitionUserData]
    var competitionCode: String = UUID().uuidString.prefix(5).uppercased()
    var isRunning: Bool
    var badgeIdentifier: BadgeIdentifier
    
    func addUserId(injectedUser: [CompetitionUserData]) -> AppCompetition {
        return AppCompetition(id: id, startDateEvent: startDateEvent, endDateEvent: endDateEvent, competitionName: competitionName, competitionDescription: competitionDescription, users: injectedUser, competitionCode: competitionCode, isRunning: isRunning, badgeIdentifier: badgeIdentifier)
    }
}
