//
//  AutoModel.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit
enum AutoModel: Int, CustomStringConvertible, CaseIterable {
    
    case item
    case model
    case number
    case year
    case distance
    case fuelType
    case vin
    
    var description: String {
        switch self {
        case .item: return "Марка"
        case .model: return "Модель"
        case .number: return "Гос.номер"
        case .year: return "Год выпуска"
        case .distance: return "Пробег"
        case .fuelType: return "Тип топлива"
        case .vin: return "VIN"
        }
    }
    
    var image: UIImage {
        switch self {
        case .item: return UIImage(named: "penwriting") ?? UIImage()
        case .model: return UIImage(named: "penwriting") ?? UIImage()
        case .number: return UIImage(named: "penwriting") ?? UIImage()
        case .year: return UIImage(named: "penwriting") ?? UIImage()
        case .distance: return UIImage(named: "penwriting") ?? UIImage()
        case .fuelType: return UIImage(named: "penwriting") ?? UIImage()
        case .vin: return UIImage(named: "penwriting") ?? UIImage()
        }
    }
}
struct CarModel {
    var item: String
    var model: String
    var number: String
    var year: String
    var distance: Float
    var vin: String
    var activFlag: Bool
    var fuelType: String
    
    static func fetchPass() -> [CarModel] {
        
        let firstItem = CarModel(item: "", model: "", number: "", year: "", distance: 0, vin: "", activFlag: false, fuelType: "")
        return [firstItem]
    }
}
