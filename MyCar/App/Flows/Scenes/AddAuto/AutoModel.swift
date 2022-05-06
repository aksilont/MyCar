//
//  AutoModel.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit
enum AutoModel: Int, CustomStringConvertible, CaseIterable {
    
    case Item
    case Model
    case Number
    case Year
    case Distance
    case FuelType
    case Vin
    
    var description: String {
        switch self {
        case .Item: return "Марка"
        case .Model: return "Модель"
        case .Number: return "Гос.номер"
        case .Year: return "Год выпуска"
        case .Distance: return "Пробег"
        case .FuelType: return "Тип топлива"
        case .Vin: return "VIN"
            
        }
    }
    
    var image: UIImage {
        switch self {
        case .Item: return UIImage(named: "penwriting") ?? UIImage()
        case .Model: return UIImage(named: "penwriting") ?? UIImage()
        case .Number: return UIImage(named: "penwriting") ?? UIImage()
        case .Year: return UIImage(named: "penwriting") ?? UIImage()
        case .Distance: return UIImage(named: "penwriting") ?? UIImage()
        case .FuelType: return UIImage(named: "penwriting") ?? UIImage()
        case .Vin: return UIImage(named: "penwriting") ?? UIImage()
            
        }
        
        
    }
    
}
