//
//  UIApplication+Ext.swift
//  MyCar
//
//  Created by Aksilont on 12.05.2022.
//

import UIKit

extension UIApplication {
   func endEditing() {
       sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
}
