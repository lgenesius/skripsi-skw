//
//  DateManager.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 20/12/21.
//

import Foundation

struct DateManager {
    static let shared = DateManager()
    
    private var currentDate = Date()
    
    private init() {}
    
    func getCurrentDayAndDateLongVersion() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: currentDate)
    }
}
