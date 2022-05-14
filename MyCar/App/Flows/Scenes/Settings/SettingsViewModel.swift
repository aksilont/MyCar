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
    @Published var pinCode = ""
    
    let lenghtPinCode = 4
    
    private let keyChain = KeychainService.standart
    
    func savePinCode() {
        keyChain.set(pinCode, forKey: "PinCode")
    }
}
