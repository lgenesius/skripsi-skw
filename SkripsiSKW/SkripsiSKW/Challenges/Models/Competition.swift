//
//  Challenges.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 03/01/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Competition: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var startDateEvent: String
    var endDateEvent: String
    var competitionName: String
    var competitionDescription: String
    var users: [CompetitionUserData]
    var competitionCode: String = UUID().uuidString.prefix(5).uppercased()
    var isRunning: Bool
    
    func addUserId(injectedUser: [CompetitionUserData]) -> Competition {
        return Competition(id: id, startDateEvent: startDateEvent, endDateEvent: endDateEvent, competitionName: competitionName, competitionDescription: competitionDescription, users: injectedUser, competitionCode: competitionCode, isRunning: isRunning)
    }
}

struct CompetitionUserData: Codable {
    var userId: String
    var userCompetitionPoint: Int
    var userName: String
    var userRank: Int = 0
    
    func addUserPoint(injectedAddNewUserPoint: Int) -> CompetitionUserData {
        return CompetitionUserData(userId: userId, userCompetitionPoint: (userCompetitionPoint + injectedAddNewUserPoint), userName: userName)
    }
    
    mutating func updateUserPoint(addedPoint: Int) {
        self.userCompetitionPoint += addedPoint
    }
    
    mutating func mapRank(rank: Int) {
        self.userRank = rank
    }
}
