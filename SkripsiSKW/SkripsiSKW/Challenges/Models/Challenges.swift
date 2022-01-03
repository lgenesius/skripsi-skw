//
//  Challenges.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 03/01/22.
//

import Foundation

struct Challenges: Codable {
    var uid: String
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
    var usersId: [String]
    var challengeCode: String
}
