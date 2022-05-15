//
//  HomeViewModel.swift
//  MyCar
//
//  Created by Denis Kuzmin on 15.05.2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var segments: [Double] = []
    @Published var names: [String] = []
    @Published var colors: [Color] = []
    var carName: String
    var carNumber: String
    var allExpencies: String
    var expenciesPerDistanceUnit: String
    var currencySign: String
    var distanceUnitSign: String
    
    init() {
        let parkColor = Color(CGColor(red: 243/255, green: 172/255, blue: 0, alpha: 1))
        let washColor = Color(CGColor(red: 69/255, green: 150/255, blue: 190/255, alpha: 1))
        let repairColor = Color(CGColor(red: 243/255, green: 0/255, blue: 0/255, alpha: 1))
        let fuelColor = Color(CGColor(red: 92/255, green: 157/255, blue: 0/255, alpha: 1))
        let finColor = Color(CGColor(red: 118/255, green: 7/255, blue: 136/255, alpha: 1))
        let otherColor = Color(CGColor(red: 71/255, green: 69/255, blue: 190/255, alpha: 1))
        
        colors = [parkColor, washColor, repairColor, fuelColor, finColor, otherColor]
        names = ["Парковка","Мойка","Ремонт","Топливо","Финансы","Прочее"]
        segments = [100,120,120, 50, 70, 90]
        carName = "Chevrolet Lacetti"
        carNumber = "C073CT150"
        allExpencies = "1000000"
        expenciesPerDistanceUnit = "500"
        currencySign = "Р"
        distanceUnitSign = "км"
    }
}
