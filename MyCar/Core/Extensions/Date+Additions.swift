//
//  Date+Additions.swift
//  MyCar
//
//  Created by Aksilont on 18.05.2022.
//

import Foundation

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    
    // Days
    
    func startOfDay(using calendar: Calendar = .gregorian) -> Date {
        return calendar.startOfDay(for: self)
    }
    
    func endOfDay(using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.date(byAdding: .day, value: 1, to: startOfDay())
        else { return self }
        return newDate - 1
    }
    
    func startOfLastDay(using calendar: Calendar = .gregorian) -> Date {
        (endOfDay() - 1).startOfDay()
    }
    
    func endOfLastDay(using calendar: Calendar = .gregorian) -> Date {
        startOfLastDay().endOfDay()
    }
    
    func startOfNextDay(using calendar: Calendar = .gregorian) -> Date {
        endOfDay() + 1
    }
    
    func endOfNextDay(using calendar: Calendar = .gregorian) -> Date {
        startOfNextDay().endOfDay()
    }
    
    func daysAgo(_ numberDaysAgo: Int, using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.date(byAdding: .day, value: -numberDaysAgo, to: startOfDay())
        else { return self }
        return newDate
    }
    
    // Weeks
    
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date
        else { return self }
        return newDate
    }
    
    func endOfWeek(using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek())
        else { return self }
        return newDate - 1
    }
    
    func startOfLastWeek(using calendar: Calendar = .gregorian) -> Date {
        (startOfWeek() - 1).startOfWeek()
    }
    
    func endOfLastWeek(using calendar: Calendar = .gregorian) -> Date {
        startOfLastWeek().endOfWeek()
    }
    
    func startOfNextWeek(using calendar: Calendar = .gregorian) -> Date {
        endOfWeek() + 1
    }
    
    func endOfNextWeek(using calendar: Calendar = .gregorian) -> Date {
        startOfNextWeek().endOfWeek()
    }
    
    // Months
    
    func startOfMonth(using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.dateComponents([.calendar, .year, .month], from: self).date
        else { return self }
        return newDate
    }
    
    func endOfMonth(using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.date(byAdding: .month, value: 1, to: startOfMonth())
        else { return self }
        return newDate - 1
    }
    
    func startOfLastMonth(using calendar: Calendar = .gregorian) -> Date {
        (startOfMonth() - 1).startOfMonth()
    }
    
    func endOfLastMonth(using calendar: Calendar = .gregorian) -> Date {
        startOfLastMonth().endOfMonth()
    }
    
    func startOfNextMonth(using calendar: Calendar = .gregorian) -> Date {
        endOfMonth() + 1
    }
    
    func endOfNextMonth(using calendar: Calendar = .gregorian) -> Date {
        startOfNextMonth().endOfMonth()
    }
    
    func monthsAgo(_ numberMonthsAgo: Int, using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.date(byAdding: .month, value: -numberMonthsAgo, to: startOfDay())
        else { return self }
        return newDate
    }
    
    // Years
    
    func startOfYear(using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.dateComponents([.calendar, .year,], from: self).date
        else { return self }
        return newDate
    }
    
    func endOfYear(using calendar: Calendar = .gregorian) -> Date {
        guard let newDate = calendar.date(byAdding: .year, value: 1, to: startOfYear())
        else { return self }
        return newDate - 1
    }
    
    func startOfLastYear(using calendar: Calendar = .gregorian) -> Date {
        (startOfYear() - 1).startOfYear()
    }
    
    func endOfLastYear(using calendar: Calendar = .gregorian) -> Date {
        startOfLastYear().endOfYear()
    }
    
    func startOfNextYear(using calendar: Calendar = .gregorian) -> Date {
        endOfYear() + 1
    }
    
    func endOfNextYear(using calendar: Calendar = .gregorian) -> Date {
        startOfNextYear().endOfYear()
    }
    
}
