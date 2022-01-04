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
    var startDateEvent: Date
    var endDateEvent: Date
    var startDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: startDateEvent)
    }
    
    var endDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: endDateEvent)
    }
    
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
}
