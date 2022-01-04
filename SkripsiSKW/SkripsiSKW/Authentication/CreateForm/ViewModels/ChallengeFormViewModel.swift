//
//  FormViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 23/12/21.
//

import Foundation
import SwiftUI
import Combine


enum CreateChallengeAlertEnum {
    case moreThanTwo
    case gettingDataError
    
    fileprivate func getAlertMessage() -> (title: String, message: String) {
        switch self {
            case .moreThanTwo:
                return ("Limit", "You’ve already joined 2 Competitions")
            case .gettingDataError:
                return ("Error!", "Getting Data Error, Try again!")
        }
    }
}

enum competitionPeriod: String, CaseIterable {
    case oneWeek = "1 Week"
    case twoWeek = "2 Weeks"
}

class ChallengeFormViewModel: ObservableObject {
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    @Published var competitionName: String = ""
    @Published var competitionDescription: String = ""
    @Published var competitionField: competitionPeriod = .oneWeek
    
    @Published var isValid: Bool = false
    @Published var isLoading = false
    
    @Published var competitionNameErrorMessage = ""
    @Published var competitionDescriptionErrorMessage = ""
    
    @Published var alertPresented = false
    
    @Published private var challengeValidatity: CreateChallengeAlertEnum = .moreThanTwo
    @Published private var alertMessage: String = ""
    @Published private var alertTitle: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var formCancellableSet: Set<AnyCancellable> = []
    private var selectedSubscriberCancellable: AnyCancellable?
    
    init() {
        
        isCompetitionNameValidPublisher
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Competition Name must not empty"
            }
            .sink(receiveValue: { [weak self] message in
                guard let self = self else { return }
                self.competitionNameErrorMessage = message
            })
            .store(in: &formCancellableSet)
        
        isCompetitionDescriptionValidPublisher
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Competition Description must not empty"
            }
            .sink(receiveValue: { [weak self] message in
                guard let self = self else { return }
                self.competitionDescriptionErrorMessage = message
            })
            .store(in: &formCancellableSet)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                guard let self = self else { return }
                self.isValid = isValid
            }
            .store(in: &formCancellableSet)
        
        selectedSubscriberCancellable = selectedSubscriber
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: RunLoop.main)
            .sink { [weak self] competitionPeriodSelected in
                guard let self = self else { return }
                self.cancellableSet.removeAll()
                switch competitionPeriodSelected {
                    case .oneWeek:
                        self.endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
                        self.addStartDateOneWeekSubscriber()
                        self.addEndDateOneWeekSubscriber()
                    case .twoWeek:
                        self.endDate = Calendar.current.date(byAdding: .day, value: 14, to: Date()) ?? Date()
                        self.addStartDateTwoWeeksSubscriber()
                        self.addEndDateTwoWeeksSubscriber()
                    }
            }
    }
    
    deinit {
        cancellableSet.removeAll()
        selectedSubscriberCancellable?.cancel()
        formCancellableSet.removeAll()
    }
    
    func getAlertData() -> (title: String, message: String) {
        return (title: self.challengeValidatity.getAlertMessage().title, message: self.challengeValidatity.getAlertMessage().message)
    }
    
    func createChallenge(completion: @escaping (() -> Void)) {
        isLoading = true
        CompetitionService.CheckValidity { [weak self] totalChallenge, error  in
            guard let self = self else { return }
            if error != nil {
                self.challengeValidatity = .gettingDataError
                self.alertPresented = true
                return
            }
            
            if let data = totalChallenge, data < 2 {
                let newCompetition = Competition(startDateEvent: self.startDate, endDateEvent: self.endDate, competitionName: self.competitionName, competitionDescription: self.competitionDescription, usersId: [], isRunning: true)
                CompetitionService.createCompetition(competition: newCompetition) {
                    self.isLoading = false
                    completion()
                } onError: { errorMessage in
                    self.isLoading = false
                    print("error")
                    completion()
                }
            } else {
                self.challengeValidatity = .moreThanTwo
                self.alertPresented = true
                completion()
            }
        }
    }
    
    private func getPastDate(past dateTo: Int, currentDate date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: -(dateTo), to: date) ?? date
    }
    
}

//MARK: List of Subscribers
extension ChallengeFormViewModel {
    private var isCompetitionNameValidPublisher: AnyPublisher<Bool, Never> {
        $competitionName
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    private var isCompetitionDescriptionValidPublisher: AnyPublisher<Bool, Never> {
        $competitionDescription
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isCompetitionNameValidPublisher, isCompetitionDescriptionValidPublisher)
            .map { competitionNameValidity, competitionDescriptionValidity in
                return competitionNameValidity && competitionDescriptionValidity
            }
            .eraseToAnyPublisher()
    }
}

//MARK: Adding Subscription Identifier
extension ChallengeFormViewModel {
    private func addStartDateOneWeekSubscriber() {
        $startDate
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .map { [unowned self] (dateStart) -> (Date, Date) in
                let range = Calendar.current.dateComponents([.day], from: dateStart, to: self.endDate).day!
                if range == 7 {
                    return (dateStart, self.endDate)
                } else {
                    let today = Date().shortDate
                    let endDate = self.endDate.shortDate
                        if endDate == today {
                            return (dateStart, self.getPastDate(past: -7, currentDate: dateStart))
                        }
                        else {
                            return (dateStart, self.getPastDate(past: -7, currentDate: dateStart))
                        }
                }
            }
            .sink { [weak self] (dateStart, dateEnd) in
                guard let self = self else { return }
                self.endDate = dateEnd
                self.startDate = dateStart
            }
            .store(in: &cancellableSet)
    }
    
    private func addEndDateOneWeekSubscriber() {
        $endDate
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .map { [unowned self] (endDate) -> (Date, Date) in
                let range = Calendar.current.dateComponents([.day], from: self.startDate, to: endDate).day!
                if range == 7 {
                    return (self.startDate, endDate)
                } else {
                    return (self.getPastDate(past: 7, currentDate: endDate), endDate)
                }
            }
            .sink { [weak self] (dateStart, dateEnd) in
                guard let self = self else { return }
                self.endDate = dateEnd
                self.startDate = dateStart
            }
            .store(in: &cancellableSet)
    }
    
    private func addStartDateTwoWeeksSubscriber() {
        $startDate
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .map { [unowned self] (dateStart) -> (Date, Date) in
                let range = Calendar.current.dateComponents([.day], from: dateStart, to: self.endDate).day!
                if range == 14 {
                    return (dateStart, self.endDate)
                } else {
                    let today = Date().shortDate
                    let endDate = self.endDate.shortDate
                        if endDate == today {
                            return (dateStart, self.getPastDate(past: -14, currentDate: dateStart))
                        }
                        else {
                            return (dateStart, self.getPastDate(past: -14, currentDate: dateStart))
                        }
                }
            }
            .sink { [weak self] (dateStart, dateEnd) in
                guard let self = self else { return }
                self.endDate = dateEnd
                self.startDate = dateStart
            }
            .store(in: &cancellableSet)
    }
    
    private func addEndDateTwoWeeksSubscriber() {
        $endDate
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .map { [unowned self] (endDate) -> (Date, Date) in
                let range = Calendar.current.dateComponents([.day], from: self.startDate, to: endDate).day!
                if range == 14 {
                    return (self.startDate, endDate)
                } else {
                    return (self.getPastDate(past: 14, currentDate: endDate), endDate)
                }
            }
            .sink { [weak self] (dateStart, dateEnd) in
                guard let self = self else { return }
                self.endDate = dateEnd
                self.startDate = dateStart
            }
            .store(in: &cancellableSet)
    }
    
    private var selectedSubscriber: AnyPublisher<competitionPeriod, Never> {
        $competitionField
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension ChallengeFormViewModel {
    private func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func startDateString() -> String {
        return dateFormatter(date: startDate)
    }
    
    func endDateString() -> String {
        return dateFormatter(date: endDate)
    }
}
