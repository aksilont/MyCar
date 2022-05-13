//
//  SettingsViewModel.swift
//  MyCar
//
//  Created by Aksilont on 12.05.2022.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var pinCode: String = "" {
        didSet {
            if pinCode.count > 5 {
                pinCode.removeLast()
            }
        }
    }
    
    private let keyChain = KeychainService.standart
    
    func savePinCode() {
        keyChain.set(pinCode, forKey: "PinCode")
    }
}
