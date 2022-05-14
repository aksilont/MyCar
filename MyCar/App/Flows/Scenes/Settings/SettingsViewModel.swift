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
            if pinCode.count == lenghtPinCode || !usePinCode{
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
}
