//
//  LoginViewModel.swift
//  MyCar
//
//  Created by Aksilont on 13.05.2022.
//

import Foundation

final class LoginViewModel {
    let keyChain = KeychainService.standart
    
    func hasPinCode() -> Bool {
        guard let data = keyChain.data(forKey: "PinCode"),
              let pinCode = String(data: data, encoding: .utf8),
              pinCode != ""
        else { return false }
        
        return true
    }
}
