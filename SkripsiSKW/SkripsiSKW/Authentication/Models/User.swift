//
//  User.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import Foundation

struct User: Codable {
    var uid: String
    var email: String
    var name: String
    var username: String
    var challenges: [Competition]
    var totalPoint: Int = 0
    var profileImageUrl: String
}
