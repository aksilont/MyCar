//
//  CarDecodable.swift
//  MyCar
//
//  Created by Alex Larin on 17.05.2022.
//

import Foundation

struct Cars: Decodable {
    var list: [String : [String]]
    enum CodingKeys: String, CodingKey {
        case list = "list"
    }
}

struct CarsForPicker {
    var item: String
    var model: [String]
}

class CarDecodable {
    var carsForPicker = CarsForPicker(item: "", model: [""])
    var itemArray = [String]()
    
    init() {
        convertForPicker()
    }
    
    func load() -> Cars {
        let path = Bundle.main.path(forResource: "cars", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let cars = try JSONDecoder().decode(Cars.self, from: data)
            return cars
            
        } catch {
            return Cars(list: ["" : [""]])
        }
    }
    
    func convertForPicker() {
        let carsDecodable = self.load().list
        for car in carsDecodable {
            var item = carsForPicker.item
            item = car.key
            itemArray.append(item)
            itemArray.sort{ $0 < $1 }
        }
    }
    
    func getModel(item: String) -> [String] {
        var models = [String]()
        let cars = load().list
        models = cars[item] ?? []
        return models
    }
    
}

