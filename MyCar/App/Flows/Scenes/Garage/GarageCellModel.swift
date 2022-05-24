//
//  GarageCellModel.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

struct GarageCellModel {
    var itemAutoLabel: String
    var modelAutoLabel: String
    var numberAutoLabel: String
    var autoImageView: UIImage
    var checkMarkImageView: UIImage
    static func fetchGarage() -> [GarageCellModel] {
        
        let firstItem = GarageCellModel(itemAutoLabel: "Нет марки",
                                        modelAutoLabel: "Нет модели",
                                        numberAutoLabel: "А123АА177",
                                        autoImageView: UIImage(named: "car2")!,
                                        checkMarkImageView: UIImage(named: "tickmark")!)
        return [firstItem]
    }
}

struct CarParametrsModel{
    let typeFuel = ["АИ-92","АИ-95","АИ-98","Дизель","Электро"]
    
    func year() -> [String]{
        var model:[String] = []
        let year = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        let formatteddate = formatter.string(from: year as Date)
        let yearNow = Int(formatteddate)
        for i in stride(from: yearNow ?? 2022, through: 1970, by: -1)  {
            model.append(String(i))
        }
        return model
    }
}
