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

    func testDeleteExpenses() {
        expensesRepo.deleteExpenses()
    }
    
    func testSaveExpenses() {
        let categoryType: CategoryType = .parking
        var items = [ManagedExpensesModel]()
        for _ in (1...50) {
            let date = Date() - Double(Int.random(in: 86400...1000000))
            let comment = "\(date)"
            let distance = Float(Int.random(in: 100...500000) / 100)
            let price = Float(Int.random(in: 100...500000) / 100)
            let newObject = expensesRepo.saveExpenses(categoryType: categoryType,
                                              date: date,
                                              price: price,
                                              distance: distance,
                                              comment: comment)
            guard let newObject = newObject else { return }
            items.append(newObject)
        }
    }
    
    func testFetchExpenses() {
        let categoryType: CategoryType = .parking
        expensesRepo.fetch(by: categoryType) { items in
            XCTAssertEqual(items.count, 10)
        }
    }
    
}
