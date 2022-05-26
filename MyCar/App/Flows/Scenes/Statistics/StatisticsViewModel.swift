//
//  StatisticsViewModel.swift
//  MyCar
//
//  Created by Aksilont on 25.05.2022.
//

import Foundation

final class StatisticsViewModel: ObservableObject {
    private let expensesRepository = ExpensesRepository()
    
    @Published var data: [Double] = []
    @Published var periodChoice = 0 {
        didSet {
            getExpenses(period: period)
        }
    }
    
    var period: Period {
        switch periodChoice {
        case 0: return .last30Days
        case 1: return .last90Days
        case 2: return .last6Months
        case 3: return .last1Year
        default: return .last30Days
        }
    }
    
    init() {
        getExpenses(period: period)
    }
    
    func getExpenses(period: Period) {
        expensesRepository.fetchAllExpenses(period: period, ascendingDate: true) { items in
            self.data = items.map { Double($0.price) }
        }
    }
    
}
