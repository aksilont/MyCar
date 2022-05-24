//
//  PinButton.swift
//  MyCar
//
//  Created by Aksilont on 05.05.2022.
//

import UIKit

class PinButton: UIButton {
    var pinState: PinState = .undefined
    
    convenience init(pinState: PinState) {
        self.init(type: .custom)
        self.pinState = pinState
    }
}
