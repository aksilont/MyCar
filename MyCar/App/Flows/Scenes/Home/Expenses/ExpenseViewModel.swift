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
    @Published var title: String
    @Published var date = Date()
    @Published var summ: Double = 0
    @Published var mileage: Double = 0
    @Published var description = String()
    @Published var previousExpenses = [ExpensesByDate]()
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
            self.previousExpenses = $0.map {ExpensesByDate(date: $0.date, summ: Double($0.price))}
        }
    }
    
    func addExpense() {
        let expenseModel = ExpensesModel(expensesType: type,
                                         date: date,
                                         price: Float(summ),
                                         distance: Float(mileage),
                                         comment: description)
        expensesRepository.saveExpenses(model: expenseModel)
        
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
}
