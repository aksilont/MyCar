//
//  Period.swift
//  MyCar
//
//  Created by Aksilont on 19.05.2022.
//

import Foundation

enum Period {
    case lastDay, lastWeek, lastMonth, lastYear
    case currentDay, currentWeek, currentMonth, currentYear
    case nextDay, nextWeek, nextMonth, nextYear
    
    case last30Days, last90Days, last6Months, last1Year
    
    func getPeriod(from date: Date = Date()) -> (start: Date, end: Date) {
        switch self {
        case .lastDay: return (date.startOfLastDay(), date.endOfLastDay())
        case .lastWeek: return (date.startOfLastWeek(), date.endOfLastWeek())
        case .lastMonth: return (date.startOfLastMonth(), date.endOfLastMonth())
        case .lastYear: return (date.startOfLastYear(), date.endOfLastYear())
            
        case .last30Days: return (date.daysAgo(30), date.endOfDay())
        case .last90Days: return (date.daysAgo(90), date.endOfDay())
        case .last6Months: return (date.monthsAgo(6), date.endOfDay())
        case .last1Year: return (date.monthsAgo(12), date.endOfDay())
        
        case .currentDay: return (date.startOfDay(), date.endOfDay())
        case .currentWeek: return (date.startOfWeek(), date.endOfWeek())
        case .currentMonth: return (date.startOfMonth(), date.endOfMonth())
        case .currentYear: return (date.startOfYear(), date.endOfYear())
        
        case .nextDay: return (date.startOfNextDay(), date.endOfNextDay())
        case .nextWeek: return (date.startOfNextWeek(), date.endOfNextWeek())
        case .nextMonth: return (date.startOfNextMonth(), date.endOfNextMonth())
        case .nextYear: return (date.startOfNextYear(), date.endOfNextYear())
        }
    }
}

