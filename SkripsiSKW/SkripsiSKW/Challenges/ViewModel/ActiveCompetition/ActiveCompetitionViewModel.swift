//
//  ActiveCompetitionViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Foundation
import Combine

final class ActiveCompetitionViewModel: ObservableObject, Identifiable {
    @Published var competition: Competition
    @Published var allUsers: [CompetitionUserData] = []
    @Published var users: [CompetitionUserData] = []
    
    var id = ""
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var timer: AnyCancellable?
    @Published var dummyTotalPointPercentage: Float = 0
    
    @Published var nextButton: Bool = false
    @Published var prevButton: Bool = false
    
    @Published private var startIndex = 0
    @Published private var endIndex = 0
    
    @Published private var totalPage = 1
    @Published private var currentPage = 1
    
    @Published var dummyTotalPoint: Int = 0
    @Published private var relatedData: CompetitionUserData = CompetitionUserData(userId: "", userCompetitionPoint: 0, userName: "")
    
    @Published var userID: String = ""
    @Published var userRanking: Int = 0
    
    private var timerSubscription: AnyCancellable? = nil
    private var cancellationSet: Set<AnyCancellable> = []
    @Published private var competitionRepository = CompetitionRepository()
    
    deinit {
        self.timerSubscription?.cancel()
    }
    
    init(competition: Competition, userId: String) {
        self.competition = competition
        self.userID = userId
        $competition.compactMap {
            $0.id
        }
        .sink { [weak self] id in
            guard let self = self else { return }
            self.id = id
        }
        .store(in: &cancellables)
        
        $competition
        .sink { [weak self] data in
            guard let self = self else { return }
            self.allUsers = data.users
            print("data Data: \(self.allUsers)")
        }
        .store(in: &cancellables)
        
        $allUsers.sink { [weak self] competitionData in
            guard let self = self else { return }
            
            if !competitionData.isEmpty {
                self.relatedData = competitionData.first(where: { userData in
                    userData.userId == self.userID
                }) ?? CompetitionUserData(userId: "", userCompetitionPoint: 0, userName: "")
                
                
                self.dummyTotalPoint = self.relatedData.userCompetitionPoint
                self.userRanking = self.relatedData.userRank
                
                print("related Data: \(self.userID)")
                
                self.initTimer()
            }
        }
        .store(in: &cancellables)
        
        
        $dummyTotalPoint
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.initTimer()
            }
            .store(in: &cancellables)

        
        initiateFirstFive()
        initTimer()
    }
    
    func setData(userData: [CompetitionUserData], userID: String) {
        self.userID = userID
        print("setData \(self.userID)")
        self.allUsers = userData

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
        self.dummyTotalPointPercentage = 0
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

extension ActiveCompetitionViewModel {
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

extension ActiveCompetitionViewModel {
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

