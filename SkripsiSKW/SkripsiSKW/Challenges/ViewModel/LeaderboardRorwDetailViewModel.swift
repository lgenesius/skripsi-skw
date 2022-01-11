//
//  LeaderboardRorwDetailViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 11/01/22.
//

import Foundation
import SwiftUI

class LeaderboardRowDetailViewModel: ObservableObject{
    @Published var sessionUser: User?
    @Published var relatedUser: User!
    var userId: String = ""
    
    
    init(userId: String, sessionVM: User) {
        self.sessionUser = sessionVM
        self.userId = userId
    }
    
    func fetchUserDetail(_ completion: @escaping (Bool) -> Void) {
        
        if userId == sessionUser?.uid {
            return completion(true)
        }
        
        UserService.getUserData(userId: self.userId) { [weak self] competitorDetail, error in
            guard error == nil else { return }
            self?.relatedUser = competitorDetail!
            return completion(false)
        }
    }
}
