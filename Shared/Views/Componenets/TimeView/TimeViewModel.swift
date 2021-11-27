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
    
    @Published private(set) var displayTimeRowOne: String = ""
    @Published private(set) var displayTimeRowTwo: String = ""

    
    init(withTime time: Time.Amount,
         shownComponents: Time.Components = .timeOnly
    ) {
        timeComponents = shownComponents
        updateViewOnTimeChange(time)
        
        formatter.numberStyle = .spellOut
    }
    
    func updateViewOnTimeChange(_ newTime: Time.Amount) {
        self.year = newTime.year != nil ? "\(newTime.year!)" : ""
        self.month = newTime.month != nil ? "\(newTime.month!)" : ""
        self.week = newTime.week != nil ? "\(newTime.week!)" : ""
        self.days = newTime.days != nil ? "\(newTime.days!)" : ""
        if let hours = newTime.hours {
            let isPM = hours >= 13
            self.hours = String(format: "%02d", isPM ? hours - 12 : hours)
        }
        if let minutes = newTime.minutes { self.minutes = String(format: "%02d", minutes) }
        self.seconds = String(format: "%02d", newTime.seconds)
        if let milliseconds = newTime.milliseconds { self.milliseconds = String(format: "%.0f", milliseconds) }
        
        setDisplayStrings()
    }
}

extension TimeViewModel {
    private func setDisplayStrings() {
        displayTimeRowOne = ""
        displayTimeRowTwo = ""
        
        if timeComponents.contains(.month) {
            displayTimeRowOne += "\(month)/"
        }

        if timeComponents.contains(.day) {
            displayTimeRowOne += "\(days)"
        }

        if timeComponents.contains(.year) {
            displayTimeRowOne += "/\(year)"
        }

        if timeComponents.contains(.week) {
            displayTimeRowOne += ", Week: \(week)"
        }
        
        if timeComponents.contains(.hour) {
            displayTimeRowTwo += "\(hours):"
        }

        if timeComponents.contains(.minute) {
            displayTimeRowTwo += "\(minutes)"
        }

        if timeComponents.contains(.second) {
            displayTimeRowTwo += ":\(seconds)"
        }

        if timeComponents.contains(.millisecond) {
            displayTimeRowTwo += ".\(milliseconds)"
        }
    }
}
