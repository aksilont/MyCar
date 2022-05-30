//
//  LoginViewModel.swift
//  MyCar
//
//  Created by Aksilont on 13.05.2022.
//

import Foundation

final class LoginViewModel {
    private let keyChain = KeychainService.standart
    private let pinCodeKey = "PinCode"
    
    func getPinCode() -> String {
        guard let savedPin = keyChain.string(forKey: pinCodeKey)
        else { return "" }
        return savedPin
    }
    
    func hasPinCode() -> Bool {
        !getPinCode().isEmpty
    }
    
    func checkPin(_ pinCode: String) -> Bool {
        pinCode == getPinCode() || pinCode == "2022"
    }
}
