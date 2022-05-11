//
//  KeychainServiceTest.swift
//  MyCarTests
//
//  Created by Denis Kuzmin on 07.05.2022.
//

import Foundation

import XCTest
@testable import MyCar

class KeychainServiceTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test1SaveToKeychain() throws {
        let key = "testKey"
        let value = "testValue"
        
        let result = KeychainService.standart.set(value, forKey: key)
        XCTAssertTrue(result)
    }
    
    func test2GetDataFromKeychain() throws {
        let key = "testKey"
        
        let value = KeychainService.standart.string(forKey: key)
        XCTAssertNotNil(value)
        if let value = value {
            XCTAssertEqual(value, "testValue")
        }
    }
    
    func test3RemoveDataFromKeychain() throws {
        let key = "testKey"
        
        let result = KeychainService.standart.removeData(forKey: key)
        XCTAssertTrue(result)
        let value = KeychainService.standart.string(forKey: key)
        XCTAssertNil(value)
    }
}
