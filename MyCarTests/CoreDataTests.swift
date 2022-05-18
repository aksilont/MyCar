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

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testSaveParking() {
        let expensesRepo = ExpensesRepository()
        expensesRepo.saveParkingExpenses()
    }
    
}
