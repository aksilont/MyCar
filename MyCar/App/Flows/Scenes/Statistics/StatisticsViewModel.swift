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
    @Published var periodChoioce = 0 {
        didSet {
            switch periodChoioce {
            case 0: getExpenses(period: .last30Days)
            case 1: getExpenses(period: .last90Days)
            case 2: getExpenses(period: .last6Months)
            case 3: getExpenses(period: .last1Year)
            default: getExpenses(period: .last30Days)
            }
        }
    }
    
    init() {
        getExpenses(period: .last30Days)
    }
    
    func getExpenses(period: Period) {
        expensesRepository.fetchExpenses(by: .parking, period: period, ascendingDate: true) { items in
            self.data = items.map { Double($0.price)}
        }
    }
    
}
