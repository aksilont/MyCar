//
//  CoreDataTests.swift
//  MyCarTests
//
//  Created by Aksilont on 18.05.2022.
//

import XCTest
import Foundation

@testable import MyCar

class CoreDataTests: XCTestCase {

    let expensesRepo = ExpensesRepository()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExpensesReository() {
        let expensesType: ExpensesType = .parking
        
        // Удаление всех записей по категории расходов парковка
        expensesRepo.deleteAllExpenses()
        
        
        // Создание 50 случайных записей
        for _ in (1...50) {
            let date = Date() - Double(Int.random(in: 86400...1000000))
            let comment = "\(date)"
            let distance = Float(Int.random(in: 100...500000) / 100)
            let price = Float(Int.random(in: 100...500000) / 100)
            let model = ExpensesModel(expensesType: expensesType,
                                      date: date,
                                      price: price,
                                      distance: distance,
                                      comment: comment)
            expensesRepo.saveExpenses(model: model)
        }
        
        // Проверка на получение
        expensesRepo.fetchExpenses(by: expensesType, limit: .max) { items in
            XCTAssertEqual(items.count, 50)
        }
    }
    
    func testDelete1Expenses() {
        // Проверка на удаление конкретной записи
        let expensesType: ExpensesType = .parking
        var someModels: ExpensesModel?
        expensesRepo.fetchExpenses(by: expensesType, limit: 1) { [unowned self] items in
            someModels = items.first
            if someModels != nil {
                expensesRepo.deleteExpenses(model: someModels!)
            }
        }
        
        if someModels != nil {
            expensesRepo.fetchExpenses(use: someModels!) { items in
                XCTAssertEqual(items.count, 0)
            }
        }
    }
    
}
