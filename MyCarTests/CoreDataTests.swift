//
//  CoreDataTests.swift
//  MyCarTests
//
//  Created by Aksilont on 18.05.2022.
//

import XCTest
//import Foundation

@testable import MyCar

class CoreDataTests: XCTestCase {

    let expensesRepo = ExpensesRepository()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testSaveParking() {
        expensesRepo.saveParkingExpenses()
    }
    
    func testFetchParking() {
        expensesRepo.fetchExpenses(by: .parking, dayAgo: 5) { items in
        }
    }
    
    func testDeleteExpenses() {
        expensesRepo.deleteExpenses()
    }
    
    func testFetchLastExpenses() {
        expensesRepo.fetchLast10Expenses(by: .parking) { items in
        }
    }
    
}
