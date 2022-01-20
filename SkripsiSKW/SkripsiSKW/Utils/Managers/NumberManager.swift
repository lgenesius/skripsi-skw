//
//  NumberManager.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 20/01/22.
//

import SwiftUI

struct NumberManager {
    static let shared = NumberManager()
    
    private init() {}
    
    func getRank(rank:Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return String(formatter.string(from: NSNumber(value: rank) )!)
    }
}

