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
    
    @Published private var allDummyData: [[String]] = [[]]
    @Published var nextButton: Bool = false
    @Published var prevButton: Bool = false
    
    @Published private var startIndex = 0
    @Published private var endIndex = 0
    
    @Published private var totalPage = 1
    @Published private var currentPage = 1
    
    var dummyTotalPoint: Int = 245
    
    private var timerSubscription: AnyCancellable? = nil
    private var cancellationSet: Set<AnyCancellable> = []
    
    init() {
        initDummyData()
        initTimer()
        initiateFirstFive()
    }
    
    deinit {
        self.timerSubscription?.cancel()
    }
    
    private func countPage() {
        let result = Double(Double(self.getTotalParticipant()) / Double(10))
        totalPage = Int(ceil(result))
    }
    
    func initiateFirstTen() {
        countPage()
        
        if self.allDummyData.count > 10 {
            self.endIndex = 9
            self.dummyData = Array(self.allDummyData[startIndex...endIndex])
            self.nextButton = true
        } else {
            self.dummyData = self.allDummyData
        }
        
        canNext
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: RunLoop.main)
            .sink { [unowned self] nextValue in
                self.nextButton = nextValue
            }
            .store(in: &cancellationSet)
        
        canPrev
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: RunLoop.main)
            .sink { [unowned self] prevValue in
                self.prevButton = prevValue
            }
            .store(in: &cancellationSet)
    }
    
    func next() {
        if endIndex + 9 >= self.allDummyData.count-1 {
            self.startIndex = self.endIndex + 1
            self.endIndex = self.allDummyData.count - 1
            self.dummyData = Array(self.allDummyData[startIndex...self.endIndex])
        } else {
            self.startIndex = startIndex + 10
            self.endIndex = startIndex + 9
            self.dummyData = Array(self.allDummyData[startIndex...endIndex])
        }
        
        self.currentPage += 1
    }
    
    func prev() {
        self.endIndex = self.startIndex - 1
        self.startIndex = self.endIndex - 9
        self.dummyData = Array(self.allDummyData[startIndex...endIndex])
        
        self.currentPage -= 1
    }
    
    private func initiateFirstFive() {
        startIndex = 0
        endIndex = 0
        if self.allDummyData.count > 5 {
            self.dummyData = Array(self.allDummyData[startIndex...4])
        } else {
            self.dummyData = self.allDummyData
        }
    }
    
    private func initTimer() {
        let point = self.dummyTotalPoint
        self.timerSubscription = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .scan(0, { (count, _) in
                return count + 1
            })
            .filter({ (count) in
                return count <= point
            })
            .sink { [weak self] timeStamp in
                guard let self = self else { return }
                self.dummyTotalPointPercentage = Float(timeStamp) / Float(300)
            }
    }
}

extension CompetitionViewModel {
    func getTotalParticipant() -> Int {
        return allDummyData.count
    }
    
    func getListIncrement() -> Int {
        return startIndex
    }
    
    func reset() {
        initiateFirstFive()
        startIndex = 0
        endIndex = 0
    }
    
    func getListSize() -> Int {
        return self.dummyData.count
    }
    
    
    func getPagination() -> (currentPage: Int, totalPage: Int) {
        return (self.currentPage, self.totalPage)
    }
    
}

extension CompetitionViewModel {
    private var canNext: AnyPublisher<Bool, Never> {
        $endIndex
            .map { [unowned self] endIndexValue in
                if self.allDummyData.count < 10 { return false }
                else if endIndexValue != self.allDummyData.count - 1 { return true }
                return false
            }
            .eraseToAnyPublisher()
    }
    
    private var canPrev: AnyPublisher<Bool, Never> {
        $startIndex
            .map { startIndexValue in
                return startIndexValue != 0
            }
            .eraseToAnyPublisher()
    }
}

extension CompetitionViewModel {
    private func initDummyData() {
        self.allDummyData = [
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
            ["Data 15", "235"],
            ["Data 16", "234"],
            ["Data 17", "233"],
            ["Data 18", "232"],
            ["Data 19", "231"],
            ["Data 20", "230"],
            ["Data 21", "0"],
            ["Data 22", "235"],
            ["Data 23", "234"],
            ["Data 24", "233"],
            ["Data 25", "232"],
            ["Data 26", "231"],
            ["Data 27", "230"],
            ["Data 28", "0"],
            ["Data 29", "0"],
            ["Data 30", "0"],
            ["Data 31", "232"],
            ["Data 32", "231"],
            ["Data 33", "230"],
            ["Data 34", "0"],
            ["Data 35", "0"],
            ["Data 36", "0"]
        ]
    }
}
