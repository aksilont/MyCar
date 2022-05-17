//
//  HomeViewModel.swift
//  MyCar
//
//  Created by Denis Kuzmin on 15.05.2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var segments: [Double] = []
    @Published var names: [String] = ["Парковка", "Мойка", "Ремонт", "Топливо", "Финансы", "Прочее"]
    @Published var colors: [Color] = [Color.park, Color.wash, Color.repair, Color.fuel, Color.finance, Color.other]
    @Published var carName: String = ""
    @Published var carNumber: String = ""
    @Published var allExpencies: String = ""
    @Published var expenciesPerDistanceUnit: String = ""
    private var currencySign: String = "₽"
    private var distanceUnit: String = "км"
    var garageButoonSubject = PassthroughSubject<Void, Never>()
    var exitButtonSubject = PassthroughSubject<Void, Never>()
    
    private var car: Car?
    
    init() {
        loadCarData()
    }
    
    func loadCarData() {
        let carRepository = CarRepository()
        car = carRepository.getActiveCar()
        
        carName = car?.item ?? "Мой автомобиль"
        carNumber = car?.number ?? ""
        calculateExpencies()
    }
    
    private func calculateExpencies() {
        let calculatedAllExpencies = 1_000_000.0
        segments = [100000, 200000, 50000, 150000, 275000, 225000]
        allExpencies = "Всего \(String(format: "%.2f", calculatedAllExpencies)) \(currencySign)"
        if let car = car, car.distance > 0 {
            expenciesPerDistanceUnit = String(format: "%.2f", calculatedAllExpencies / Double(car.distance))
        } else {
            expenciesPerDistanceUnit = "неизвестно"
        }
        expenciesPerDistanceUnit += " \(currencySign)/\(distanceUnit)"
    }
}
