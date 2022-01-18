//
//  DailyChallenge.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 18/01/22.
//

import Foundation
import FirebaseFirestoreSwift

struct DailyChallenge: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var challengeName: String
    var challengeDescription: String
    var challengeCompletion: Int
    var challengeGoal: Int
    var challengeIdentifier: String
}

struct DailyChallengeUserData: Codable {
    var userId: String
    var progress: Int
    var isCompleted: Bool
}
