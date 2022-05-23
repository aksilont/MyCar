//
//  HomeViewModel.swift
//  MyCar
//
//  Created by Denis Kuzmin on 15.05.2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    private let expensesRepository = ExpensesRepository()
    @Published var segments: [Double] = []
    var expensesTypes = ExpensesType.allCases
    var names: [String] = ExpensesType.allCases.map { $0.rawValue }
    var colors: [Color] = ExpensesType.allCases.map { Color.expenseColor($0) }
    @Published var carName: String = ""
    @Published var carNumber: String = ""
    @Published var total: String = ""
    @Published var expenciesPerDistanceUnit: String = ""
    @Published var isActiveCar: Bool = false
    @Published var homeNeedsToUpdate: Bool = false {
        didSet {
            calculateExpenses()
        }
    }
    @Published var shouldShowAverage: Bool = false
    private var currencySign: String = "₽"
    private var distanceUnit: String = "км"
    var garageButtonSubject = PassthroughSubject<Void, Never>()
    
    private var car: Car?
    
    init() {
        loadCarData()
    }
    
    func loadCarData() {
        let carRepository = CarRepository()
        car = carRepository.getActiveCar()
        
        guard let car = car else {
            isActiveCar = false
            return
        }
        isActiveCar = true
        carName = car.item ?? "Мой автомобиль"
        carNumber = car.number ?? ""
    }
    
    func calculateExpenses() {
        var allExpenses: [ExpensesType: Double] = [:]
        expensesTypes.forEach { type in
            expensesRepository.fetchExpenses(by: type, limit: .max) { expenses in
                let summ = expenses.map {$0.price}.reduce(0, +)
                allExpenses[type] = Double(summ)
            }
        }

        segments = expensesTypes.map { allExpenses[$0] ?? 0 }
        let calculatedTotal = segments.reduce(0, +)
        total = "Всего \(String(format: "%.2f", calculatedTotal)) \(currencySign)"
        if let car = car, car.distance > 0 {
            expenciesPerDistanceUnit = String(format: "%.2f", calculatedTotal / Double(car.distance))
            shouldShowAverage = true
        } else {
            shouldShowAverage = false
        }
        expenciesPerDistanceUnit += " \(currencySign)/\(distanceUnit)"
    }
    
    func didTapGarageButton() {
        garageButtonSubject.send()
    }
}
