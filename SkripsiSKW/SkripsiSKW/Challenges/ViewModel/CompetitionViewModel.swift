//
//  CompetitionViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import Foundation
import Combine

class CompetitionViewModel: ObservableObject {
    @Published var timer: AnyCancellable?
    @Published var dummyTotalPointPercentage: Float = 0
    
    @Published var allUsers: [CompetitionUserData] = []
    @Published var users: [CompetitionUserData] = []
    
    @Published var nextButton: Bool = false
    @Published var prevButton: Bool = false
    
    @Published private var startIndex = 0
    @Published private var endIndex = 0
    
    @Published private var totalPage = 1
    @Published private var currentPage = 1
    
    var dummyTotalPoint: Int = 245
    var userID: String = ""
    
    private var timerSubscription: AnyCancellable? = nil
    private var cancellationSet: Set<AnyCancellable> = []
    private var competitionRepository = CompetitionRepository()
    
    init() {
        initiateFirstFive()
    }
    
    deinit {
        self.timerSubscription?.cancel()
    }
    
    func setData(userData: [CompetitionUserData], userID: String) {
        self.allUsers = userData
        self.userID = userID
        
        let relatedData = self.allUsers.first(where: { userData in
            userData.userId == self.userID
        })
        dummyTotalPoint = relatedData?.userCompetitionPoint ?? 0
        initTimer()
    }
    
    func leaveCompetition(competitionId: String) {
        competitionRepository.getOutOfCompetition(competitionId) {
            self.competitionRepository.get()
        } onError: { errorMessage in
            
        }

    }
    
    private func countPage() {
        let result = Double(Double(self.getTotalParticipant()) / Double(10))
        totalPage = Int(ceil(result))
    }
    
    func initiateFirstTen() {
        countPage()
        
        if self.allUsers.count > 10 {
            self.endIndex = 9
            self.users = Array(self.allUsers[startIndex...endIndex])
            self.nextButton = true
        } else {
            self.users = self.allUsers
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
        if endIndex + 9 >= self.allUsers.count-1 {
            self.startIndex = self.endIndex + 1
            self.endIndex = self.allUsers.count - 1
            self.users = Array(self.allUsers[startIndex...self.endIndex])
        } else {
            self.startIndex = startIndex + 10
            self.endIndex = startIndex + 9
            self.users = Array(self.allUsers[startIndex...endIndex])
        }
        
        self.currentPage += 1
    }
    
    func prev() {
        self.endIndex = self.startIndex - 1
        self.startIndex = self.endIndex - 9
        self.users = Array(self.allUsers[startIndex...endIndex])
        
        self.currentPage -= 1
    }
    
    private func initiateFirstFive() {
        startIndex = 0
        endIndex = 0
        if self.allUsers.count > 5 {
            self.users = Array(self.allUsers[startIndex...4])
        } else {
            self.users = self.allUsers
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
        return allUsers.count
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
        return self.users.count
    }
    
    
    func getPagination() -> (currentPage: Int, totalPage: Int) {
        return (self.currentPage, self.totalPage)
    }
    
}

extension CompetitionViewModel {
    private var canNext: AnyPublisher<Bool, Never> {
        $endIndex
            .map { [unowned self] endIndexValue in
                if self.allUsers.count < 10 { return false }
                else if endIndexValue != self.allUsers.count - 1 { return true }
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
