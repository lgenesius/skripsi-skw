//
//  CompetitionViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import Foundation
import Combine

class CompetitionViewModel: ObservableObject {
    @Published var dummyData: [[String]] = [[]]
    @Published var timer: AnyCancellable?
    @Published var dummyTotalPointPercentage: Float = 0
    
    var dummyTotalPoint: Int = 287
    
    private var timerSubscription: AnyCancellable? = nil
    
    init() {
        initDummyData()
        initTimer()
    }
    
    deinit {
        self.timerSubscription?.cancel()
    }
    
    private func initTimer() {
        let point = self.dummyTotalPoint
        self.timerSubscription = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .scan(0, { (count, _) in
                return count + 1
            })
            .filter({ (count) in
                return count < point
            })
            .sink { [weak self] timeStamp in
                guard let self = self else { return }
                self.dummyTotalPointPercentage = Float(timeStamp) / Float(300)
            }
    }
}

extension CompetitionViewModel {
    private func initDummyData() {
        self.dummyData = [
            ["Data 1", "245"],
            ["Data 2", "243"],
            ["Data 3", "241"],
            ["Data 4", "239"],
            ["Data 5", "238"],
            ["Data 6", "237"],
            ["Data 7", "236"],
            ["Data 8", "235"],
            ["Data 9", "234"],
            ["Data 10", "233"],
            ["Data 11", "232"],
            ["Data 12", "231"],
            ["Data 13", "230"],
            ["Data 14", "0"],
        ]
    }
}
