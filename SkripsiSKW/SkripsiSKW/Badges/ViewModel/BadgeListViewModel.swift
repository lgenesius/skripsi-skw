//
//  AllBadgeViewModel.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 05/01/22.
//

import Combine
import SwiftUI

class BadgeListViewModel: ObservableObject {
    @Published var userBadgeListViewModel: [BadgeViewModel] = []
    @Published private var badgeRepository = BadgeRepository()
    @Published var selectedBadgeViewModel: BadgeViewModel = BadgeViewModel(userBadge: UserBadge(competitionId: "", name: "", description: "", image: "", goal: 123, progress: 0, recievedDate: Date(), isHighlighted: true, identifier: ""))
    @Published var showBadgeDetail: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getData(){
        
    }
    
    func selectBadgeViewModel(badgeVM: BadgeViewModel) {
        self.selectedBadgeViewModel = badgeVM
    }
    
    func topThree() -> [BadgeViewModel] {
        if !userBadgeListViewModel.isEmpty {
            let top3 = Array(userBadgeListViewModel.filter {
                $0.userBadge.isHighlighted == true
            })
            if top3.isEmpty{
                return Array(userBadgeListViewModel.prefix(3))
            }else{
                return top3
            }
        }
        return []
    }
//    func latestBadge() -> [BadgeViewModel] {
////        if !userBadgeListViewModel.isEmpty {
////            let latest = Array(userBadgeListViewModel.filter {
////                $0.userBadge.recievedDate
////            })
////
////            if top3.isEmpty{
////                return Array(userBadgeListViewModel.prefix(3))
////            }else{
////                return top3
////            }
////        }
////        return []
//    }
    init() {
        badgeRepository.$userBadges
            .map { userBadges in
                userBadges.map(BadgeViewModel.init)
            }
            .sink { [weak self] badgesVM in
                guard let self = self else { return }
                self.userBadgeListViewModel = badgesVM
            }
            .store(in: &cancellables)
    }
    
    func fetchUserBadges(sessionVM: SessionViewModel) {
        badgeRepository.getUserBadges(sessionVM: sessionVM)
    }
    
    func fetchUserDetailBadges(userId: String) {
        badgeRepository.getUserDetailBadges(userId: userId)
    }
}

