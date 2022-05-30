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
    
    @Published var expensesGroupedModels: [ExpensesGroupedModel] = []
    @Published var wrappedExpensesModels: [ExpensesModel] = []
    
    @Published var periodChoice = 0 {
        didSet {
            groupByPeriod(period: period)
            wrapModelsByTypeAndPeriod(period: period)
        }
    }
    
    @Published var currentIndex: Int = -1
    var currentModel: ExpensesGroupedModel? {
        if currentIndex >= 0 { return expensesGroupedModels[currentIndex] }
        return nil
    }
    
    var totalExpenses: Double {
        wrappedExpensesModels.compactMap { Double($0.price) }.reduce(0.0, +)
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
    
    var startOfPeriod: Date {
        period.getPeriod().start
    }
    
    var endOfPeriod: Date {
        period.getPeriod().end
    }
    
    init() {
        getExpenses(period: period)
        wrapModelsByTypeAndPeriod(period: period)
    }
    
    func getExpenses(period: Period) {
        expensesRepository.fetchAllExpenses(period: period, ascendingDate: true) { items in
            self.data = items.map { Double($0.price) }
        }
    }
    
    func grouByPeriod(dates: [Date], separatorDays: Int, numberOfGroups: Int) -> [(start: Date, end: Date)] {
        guard let startDate = dates.first else { return [] }
        
        var result: [(start: Date, end: Date)] = []
        
        var startPeriod = startDate.startOfDay()
        var endPeriod = startPeriod
        
        for _ in (1...numberOfGroups) {
            endPeriod = startPeriod.daysAgo(-(separatorDays-1)).endOfDay()
            result.append((start: startPeriod, end: endPeriod))
            startPeriod = endPeriod + 1
        }
        return result
    }
    
    func group(models: [ExpensesModel], by period: Period) -> [ExpensesGroupedModel] {
        guard let startDate = models.first?.date else { return [] }
        
        var numberOfGroups = 15
        var separatorDays = 2
        
        switch period {
        case .last30Days:
            numberOfGroups = 15
            separatorDays = 2
        case .last90Days:
            numberOfGroups = 15
            separatorDays = 6
        case .last6Months:
            numberOfGroups = 18
            separatorDays = 10
        case .last1Year:
            numberOfGroups = 12
            separatorDays = 31
        default:
            break
        }
        
        var result: [ExpensesGroupedModel] = []
        
        var startPeriod = startDate.startOfDay()
        var endPeriod = startPeriod
        
        for _ in (1...numberOfGroups) {
            endPeriod = startPeriod.daysAgo(-(separatorDays-1)).endOfDay()
            let value = models
                .filter { ($0.date > startPeriod) && ($0.date < endPeriod) }
            if value.count > 0 {
                result.append(ExpensesGroupedModel(period: (startPeriod, endPeriod), models: value))
            }
            startPeriod = endPeriod + 1
        }
        
        return result
    }
    
    
    func groupByPeriod(period: Period) {
        expensesRepository.fetchAllExpenses(period: period, ascendingDate: true) { [unowned self] items in
            expensesGroupedModels = group(models: items, by: period).compactMap { $0.groupByType() }
            let values = expensesGroupedModels
                .compactMap { $0.models.compactMap { Double($0.price) }.reduce(0.0, +) }
            data = values
        }
    }
    
    func wrapModelsByTypeAndPeriod(period: Period) {
        expensesRepository.fetchAllExpenses(period: period, ascendingDate: true) { [unowned self] items in
            let expensesGroupedModel = ExpensesGroupedModel(period: period.getPeriod(), models: items)
            let wrapedGroupedModel = expensesGroupedModel.groupByType()
            wrappedExpensesModels = wrapedGroupedModel.models
        }
    }

}
