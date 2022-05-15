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
    var carName: String = ""
    var carNumber: String = ""
    var allExpencies: String = ""
    var expenciesPerDistanceUnit: String = ""
    var currencySign: String = ""
    var distanceUnitSign: String = ""
    
    init() {
        
        
        colors = [Color.park, Color.wash, Color.repair, Color.fuel, Color.finance, Color.other]
        names = ["Парковка","Мойка","Ремонт","Топливо","Финансы","Прочее"]
        segments = [100,120,120, 50, 70, 90]
        carName = ""
        carNumber = "C073CT150"
        allExpencies = "1000000"
        expenciesPerDistanceUnit = "500"
        currencySign = "Р"
        distanceUnitSign = "км"
        let carRepository = CarRepository()
        guard let car = carRepository.getActiveCar() else { return }
        
        carName = car.item ?? ""
        carNumber = car.number ?? ""
        
    }
    
    func reloadData() {
        let carRepository = CarRepository()
        guard let car = carRepository.getActiveCar() else { return }
        
        carName = car.item ?? ""
        carNumber = car.number ?? ""
    }
}
