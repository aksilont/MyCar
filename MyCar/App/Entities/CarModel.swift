//
//  CarModel.swift
//  MyCar
//
//  Created by Aksilont on 24.05.2022.
//

import Foundation

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
        let firstItem = CarModel(item: "",
                                 model: "",
                                 number: "",
                                 year: "",
                                 distance: 0,
                                 vin: "",
                                 activFlag: false,
                                 fuelType: "")
        return [firstItem]
    }
}
