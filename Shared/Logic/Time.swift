//
//  TimeHelper.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Combine
import Foundation

final class Time: ObservableObject {
    struct Components: OptionSet {
        let rawValue: Int
        static let year = Components(rawValue: 1 << 7)
        static let month = Components(rawValue: 1 << 6)
        static let week = Components(rawValue: 1 << 5)
        static let day = Components(rawValue: 1 << 4)
        static let hour = Components(rawValue: 1 << 3)
        static let minute = Components(rawValue: 1 << 2)
        static let second = Components(rawValue: 1 << 1)
        static let millisecond = Components(rawValue: 1 << 0)
        
        static let timeOnly: Components = [.hour, .minute, .second]
        static let calendarDate: Components = [.year, .month, .day]
    }
    
    final class Amount: ObservableObject {
        @Published private(set) var year: Int? = nil
        @Published private(set) var month: Int? = nil
        @Published private(set) var week: Int? = nil
        @Published private(set) var days: Int? = nil
        @Published private(set) var hours: Int? = nil
        @Published private(set) var minutes: Int? = nil
        @Published private(set) var seconds: Int
        @Published private(set) var milliseconds: Double? = nil
        
        enum AmountType {
            case year
            case month
            case week
            case days
            case hours
            case minutes
            case seconds
            case milliseconds
        }
        
        init(days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0, milliseconds: Double = 0.0) {
            self.days = days
            self.hours = hours
            self.minutes = minutes
            self.seconds = seconds
            self.milliseconds = milliseconds
        }
        
        convenience init(totalSeconds: Double) {
            let newAmount = Time.daysHoursMinutesSecondsFromTotalSeconds(totalSeconds)

            self.init(days: newAmount.days,
                      hours: newAmount.hours,
                      minutes: newAmount.minutes,
                      seconds: newAmount.seconds,
                      milliseconds: newAmount.milliseconds)
        }
        
        func updateFrom(totalSeconds: Double) {
            let newAmount = Time.daysHoursMinutesSecondsFromTotalSeconds(totalSeconds)
            days = newAmount.days
            hours = newAmount.hours
            minutes = newAmount.minutes
            seconds = newAmount.seconds
            milliseconds = newAmount.milliseconds
        }
        
        func updateFromDate(_ date: Date = Date()) {
            let components = Calendar.current.dateComponents([.year, .month, .weekday, .weekdayOrdinal, .day, .hour, .minute, .second, .nanosecond], from: date)
            year = components.year
            month = components.month
            week = components.weekday ?? 0
            days = components.day ?? 0
            hours = components.hour ?? 0
            minutes = components.minute ?? 0
            seconds = components.second ?? 0
            milliseconds = Double(components.nanosecond ?? 0) / 100000
        }
        
        var description: String {
            """
            \(String(describing: year)) \n
            \(String(describing: month)) \n
            \(String(describing: week)) \n
            \(String(describing: days)) \n
            \(String(describing: hours)) \n
            \(String(describing: minutes)) \n
            \(String(describing: seconds)) \n
            \(String(describing: milliseconds)) \n
            """
        }
    }
    
    static func daysHoursMinutesSecondsFromTotalSeconds(_ totalSeconds: Double) -> (days: Int, hours: Int, minutes: Int, seconds: Int, milliseconds: Double) {
        var remainingSeconds = totalSeconds
        var days = 0, hours = 0, minutes = 0, seconds = 0, milliseconds = 0.0
        
        if (remainingSeconds >= 86400) {
            days = Int(remainingSeconds / 86400)
            remainingSeconds = remainingSeconds.truncatingRemainder(dividingBy: 86400)
        }
        
        if (remainingSeconds >= 3600) {
            hours = Int(remainingSeconds / 3600)
            remainingSeconds = remainingSeconds.truncatingRemainder(dividingBy: 3600)
        }
        
        if (remainingSeconds >= 60) {
            minutes = Int(remainingSeconds / 60)
            remainingSeconds = remainingSeconds.truncatingRemainder(dividingBy: 60)
        }
        
        seconds = Int(remainingSeconds)
        milliseconds = remainingSeconds.truncatingRemainder(dividingBy: 1) * 1000
        
        return (days: days, hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds)
    }
}
