//
//  ValidationManager.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 18/12/21.
//

import Foundation

final class Validator {
    
    func checkEmailAuthenticity(_ email: String) -> Bool {
        guard !email.isEmpty else { return false }
        if email.contains("@") {
            if email.first! != "@" { return true }
        }
        return false
    }
    
    func checkMoreThan7Chars(_ string: String) -> Bool {
        return string.count > 7 ? true: false
    }
}
