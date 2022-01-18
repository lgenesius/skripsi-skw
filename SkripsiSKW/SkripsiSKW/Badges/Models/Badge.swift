//
//  Badge.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 05/01/22.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Badge: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name : String
    var description : String
    var image : String
    var goal : Int
    var identifier: BadgeIdentifier
}

struct UserBadge: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var competitionId: String
    var name : String
    var description : String
    var image : String
    var goal : Int
    var progress : Int
    var recievedDate : Date
    var isHighlighted : Bool
    var identifier: String
    
    func modifyBadgeFromStub(injectedBadge: Badge) -> UserBadge {
        return UserBadge(competitionId: injectedBadge.id ?? "", name: injectedBadge.name, description: injectedBadge.description, image: injectedBadge.image, goal: injectedBadge.goal, progress: progress, recievedDate: recievedDate, isHighlighted: isHighlighted, identifier: injectedBadge.identifier.rawValue)
    }
}
