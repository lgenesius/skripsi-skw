//
//  FormViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 23/12/21.
//

import Foundation
import SwiftUI
import Combine

class ChallengeFormViewModel: ObservableObject {
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    @Published var isDateValid: Bool = false
    @Published var competitionName: String = ""
    @Published var competitionDescription: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        addStartDateSubscriber()
        addEndDateSubscriber()
    }
    
    private func getPastDate(past dateTo: Int, currentDate date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: -(dateTo), to: date) ?? date
    }
}

//MARK: Adding Subscription Identifier
extension ChallengeFormViewModel {
    private func addStartDateSubscriber() {
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
    
    private func addEndDateSubscriber() {
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
