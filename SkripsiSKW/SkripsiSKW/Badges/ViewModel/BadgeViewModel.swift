//
//  BadgeViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 07/01/22.
//

import Combine

class BadgeViewModel: ObservableObject, Identifiable {
    @Published var userBadge: UserBadge
    
    var id = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init(userBadge: UserBadge) {
        self.userBadge = userBadge
        $userBadge.compactMap {
            $0.id
        }
        .sink { [weak self] id in
            guard let self = self else { return }
            self.id = id
        }
        .store(in: &cancellables)
    }
}
