//
//  Date+Extension.swift
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
    
}
