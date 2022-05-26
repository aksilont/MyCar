//
//  SettingsViewModel.swift
//  MyCar
//
//  Created by Aksilont on 12.05.2022.
//

import Foundation
import UIKit
import Combine

class SettingsViewModel: ObservableObject {
    private let keyChain = KeychainService.standart
    private let pinCodeKey = "PinCode"
    
    private let expensesRepository = ExpensesRepository()
    
    let lenghtPinCode = 4
    
    @Published var usePinCode = false {
        didSet {
            if !usePinCode {
                pinCode = ""
            }
        }
    }
    @Published var correctPinCode = false
    @Published var pinCode = "" {
        didSet {
            if pinCode.count == lenghtPinCode || !usePinCode {
                correctPinCode = true
                if savePinCode() { UIApplication.shared.endEditing() }
            } else {
                correctPinCode = false
            }
        }
    }
    
    init() {
        usePinCode = hasPinCode()
        pinCode = getPinCode()
    }
    
    func getPinCode() -> String {
        guard let data = keyChain.data(forKey: pinCodeKey),
              let savedPin = String(data: data, encoding: .utf8)
        else { return "" }
        return savedPin
    }
    
    func savePinCode() -> Bool {
        let savedPin = getPinCode()
        if savedPin != pinCode {
            keyChain.set(pinCode, forKey: pinCodeKey)
            return true
        }
        return false
    }

    func hasPinCode() -> Bool {
        !getPinCode().isEmpty
    }
    
    func createTestingExpenses() {
        for expensesType in ExpensesType.allCases {
            createTestingExpenses(by: expensesType)
        }
    }
    
    func createTestingExpenses(by expensesType: ExpensesType) {
        let day = 86400
        // Создание 50 случайных записей
        for _ in (1...50) {
            let date = Date() - Double(Int.random(in: day...day * 365))
            let comment = "\(date)"
            let distance = Float(Int.random(in: 100...500000) / 100)
            let price = Float(Int.random(in: 100...500000) / 100)
            let model = ExpensesModel(expensesType: expensesType,
                                      date: date,
                                      price: price,
                                      distance: distance,
                                      comment: comment)
            expensesRepository.saveExpenses(model: model)
        }
    }
    
    func deleteAllExpenses() {
        expensesRepository.deleteAllExpenses()
    }
    
}
