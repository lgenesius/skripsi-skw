//
//  AllBadgeViewModel.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 05/01/22.
//

import SwiftUI

class AllBadgeViewModel: ObservableObject {
    @Published var userBadges : [Badge] = []
    @Published var showBadgeDetail = false
    func getData(){
        
    }
    init() {
        
    }
    
    
}

