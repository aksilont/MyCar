//
//  FuelModel.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//


import UIKit
enum FuelModel: Int, CustomStringConvertible, CaseIterable {
    
    case AI92
    case AI95
    case AI98
    case Diesel
    case Electro
    
    var description: String {
        switch self {
        case .AI92: return "АИ-92"
        case .AI95: return "АИ-95"
        case .AI98: return "АИ-98"
        case .Diesel: return "Дизель"
        case .Electro: return "Электро"
        }
    }
    
}
