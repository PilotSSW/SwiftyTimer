//
//  MultiArcViewModel.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Combine
import Foundation

class MultiArcViewModel: ObservableObject {
    private var store = Set<AnyCancellable>()
    @Published var time: Time.Amount
    
    @Published var weekProgress: CGFloat = 0.0
    @Published var dayProgress: CGFloat = 0.0
    @Published var hoursProgress: CGFloat = 0.0
    @Published var minutesProgress: CGFloat = 0.0
    @Published var secondsProgress: CGFloat = 0.0
        
    init(withTime time: Time.Amount) {
        self.time = time
        $time.sink { newTime in
            self.updateViewOnTimeChange(newTime)
        }
        .store(in: &store)
    }
    
    func updateViewOnTimeChange(_ newTime: Time.Amount) {
        secondsProgress = CGFloat(newTime.milliseconds ?? 0) / 100
        minutesProgress = CGFloat(newTime.seconds) * (10 / 6) + (secondsProgress / 60)
        hoursProgress = CGFloat(newTime.minutes ?? 0) * (10 / 6) + (minutesProgress / 60)
        dayProgress = CGFloat(newTime.hours ?? 0) * (100 / 24) + (hoursProgress / 24)
        weekProgress = CGFloat((newTime.week ?? 1) - 1) * (100 / 7) + (dayProgress / 7)
    }
    
    var description: String {
        """
        \(weekProgress)
        \(dayProgress)
        \(hoursProgress)
        \(minutesProgress)
        \(secondsProgress)
        """
    }
}
