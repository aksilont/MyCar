//
//  FuelModel.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//


import UIKit
enum FuelModel: Int, CustomStringConvertible, CaseIterable {
    
    case ai92
    case ai95
    case ai98
    case diesel
    case electro
    
    var description: String {
        switch self {
        case .ai92: return "АИ-92"
        case .ai95: return "АИ-95"
        case .ai98: return "АИ-98"
        case .diesel: return "Дизель"
        case .electro: return "Электро"
        }
    }
    
}
