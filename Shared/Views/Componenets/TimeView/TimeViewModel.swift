//
//  TimeViewModel.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import Combine
import Foundation

class TimeViewModel: ObservableObject {
    private var store = Set<AnyCancellable>()
//    @Published private var time: Time.Amount
    private var formatter = NumberFormatter()
    
    @Published private(set) var timeComponents: Time.Components
    
    @Published private(set) var year: String = ""
    @Published private(set) var month: String = ""
    @Published private(set) var week: String = ""
    @Published private(set) var days: String = ""
    @Published private(set) var hours: String = ""
    @Published private(set) var minutes: String = ""
    @Published private(set) var seconds: String = ""
    @Published private(set) var milliseconds: String = ""
    
    init(withTime time: Time.Amount,
         shownComponents: Time.Components = .timeOnly
    ) {
        timeComponents = shownComponents
//        self.time = time
//        $time.sink { newTime in
            self.updateViewOnTimeChange(time)
//        }
//        .store(in: &store)
        
        formatter.numberStyle = .spellOut
    }
    
    func updateViewOnTimeChange(_ newTime: Time.Amount) {
        self.year = String(newTime.year)
        self.month = String(newTime.month)
        self.week = String(newTime.week)
        self.days = String(newTime.days)
        if let hours = newTime.hours {
            let isPM = hours >= 13
            self.hours = String(format: "%02d", isPM ? hours - 12 : hours)
        }
        if let minutes = newTime.minutes { self.minutes = String(format: "%02d", minutes) }
        self.seconds = String(format: "%02d", newTime.seconds)
        if let milliseconds = newTime.milliseconds { self.milliseconds = String(format: "%.f", milliseconds / 100000) }
    }
}
