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

    func testSaveExpenses() {
        let expensesType: ExpensesType = .parking
        
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
    }
    
    func testDeleteExpenses() {
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
    
    func testFetchExpenses() {
        let expensesType: ExpensesType = .parking
        expensesRepo.fetchExpenses(by: expensesType) { items in
            XCTAssertEqual(items.count, 10)
        }
    }
    
    func testDeleteAllExpenses() {
        expensesRepo.deleteAllExpenses()
        
        for expensesType in ExpensesType.allCases {
            expensesRepo.fetchExpenses(by: expensesType) { items in
                XCTAssertEqual(items.count, 0)
            }
        }
    }
    
}
