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

/*struct GarageConstants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - GarageConstants.leftDistanceToView - GarageConstants.rightDistanceToView - (GarageConstants.galleryMinimumLineSpacing / 2)) / 2
}*/
