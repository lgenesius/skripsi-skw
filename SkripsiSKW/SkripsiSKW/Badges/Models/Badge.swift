//
//  Badge.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 05/01/22.
//

import SwiftUI

struct Badge: Codable {
    var name : String
    var description : String
    var image : String
    var goal : Int
    var progress : Int
    var recievedDate : Date
    var isTop3 : Bool
}

