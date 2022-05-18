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


class CarDecodable {
   
    func load() -> Cars {
        let path = Bundle.main.path(forResource: "cars", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let cars = try JSONDecoder().decode(Cars.self, from: data)
          //  print("cars\(cars.list.keys.first), \(cars.list[cars.list.keys.first])")
            return cars
           
        } catch {
            return Cars(list: ["" : [""]])
        }
    }
    
    func convertForPicker() {
        
    }
    
}
