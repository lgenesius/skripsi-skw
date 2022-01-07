//
//  JoinChallengeEnum.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 04/01/22.
//

import Foundation


enum JoinChallengeEnum {
    case valid
    case moreThanTwo
    case insideTheCompetition
    case inValid
    case error
    
    func getAlertMessage() -> (title: String, message: String) {
        switch self {
            case .valid:
                return ("Valid", "Competition Joined!")
            case .moreThanTwo:
                return ("Limit", "You’ve already joined 2 Competitions")
            case .insideTheCompetition:
                return ("Same Competition", "You are already inside the competition")
            case .inValid:
                return ("Invalid", "The Competition Code Doesn't Exist")
            case .error:
                return("Error", "Error Bro")
        }
    }
}
