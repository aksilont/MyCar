//
//  ExpenseViewModel.swift
//  MyCar
//
//  Created by Denis Kuzmin on 18.05.2022.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    private let expensesRepository = ExpensesRepository()
    private var type: ExpensesType
    private var allExpenses = [ExpensesModel]()
    @Published var title: String
    @Published var date = Date()
    @Published var summ: Double = 0
    @Published var mileage: Double = 0
    @Published var description = String()
    @Published var previousExpenses = [ExpensesByDate]()
    @Published var alert = false
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    init(type: ExpensesType) {
        self.type = type
        self.title = type.rawValue
        getExpenses()
    }
    
    private func getExpenses() {
        expensesRepository.fetchExpenses(by: type, limit: .max) {
            self.allExpenses = $0
            self.previousExpenses = $0.map {ExpensesByDate(date: $0.date, summ: Double($0.price))}
        }
    }
    
    func addExpense() {
        guard checkMileageAndDate() else {
            alert = true
            return
        }
        alert = false
        
        let newExpense = ExpensesModel(expensesType: type,
                                         date: date,
                                         price: Float(summ),
                                         distance: Float(mileage),
                                         comment: description)
        expensesRepository.saveExpenses(model: newExpense)
        allExpenses.append(newExpense)
        
        let dateString = dateFormatter.string(from: date)
        if let index = previousExpenses.firstIndex(where: { $0.dateString == dateString }) {
            previousExpenses[index].summ += summ
        } else {
            let newExpense = ExpensesByDate(date: date, summ: summ)
            previousExpenses.insert(newExpense, at: 0)
        }
        
        previousExpenses.sort(by: { $0.date > $1.date })
        date = Date()
        summ = 0
        description = ""
    }
    
    private func checkMileageAndDate() -> Bool {
        allExpenses.sort(by: { $0.date < $1.date })
        let maxMileage: Double = Double(allExpenses.last?.distance ?? 0)
        let maxDate = allExpenses.last?.date ?? Date(timeIntervalSince1970: 0)
        var previousMileage: Double = 0
        var nextMileage: Double = 0
        if let index = allExpenses.firstIndex(where: {$0.date > date}), index > 0 {
            previousMileage = Double(allExpenses[index - 1].distance)
            nextMileage = Double(allExpenses[index].distance)
        }
        if (date >= maxDate && mileage >= maxMileage) ||
            (mileage <= nextMileage && mileage >= previousMileage) {
            return true
        } else {
            return false
        }
    }
}
