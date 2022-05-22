//
//  CarRepository.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//

import UIKit
import CoreData

class CarRepository {
    
    private let storage = CoreDataStack.shared
    
    // Сохранение в CoreData
    func saveCar(carModel: CarModel) {
        let context = storage.mainContext
        let carObject = Car(context: context)
        carObject.activFlag = carModel.activFlag
        carObject.number = carModel.number
        carObject.vin = carModel.vin
        carObject.fuelType = carModel.fuelType
        carObject.distance = carModel.distance
        carObject.year = carModel.year
        carObject.model = carModel.model
        carObject.item = carModel.item
        storage.saveContext()
    }
    
    // Получение из CoreData
    func fetchCars() -> [Car]{
        var cars: [Car] = []

        let context = storage.mainContext
        do {
            let request = Car.fetchRequest() as NSFetchRequest<Car>
            cars = try context.fetch(request)
            DispatchQueue.main.async {
                print("Fetch Cars from CoreData")
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
            
        }
        return cars
    }
    
    func fetchCarsUseNumber(carModel: CarModel) -> [Car] {
        let context = storage.mainContext
        let carNumber = carModel.number
        var cars: [Car] = []
        do {
            let request = Car.fetchRequest() as NSFetchRequest<Car>
            let pred = NSPredicate(format: "number CONTAINS %@", carNumber)
            request.predicate = pred
            cars = try context.fetch(request)
            DispatchQueue.main.async {
                print("Fetch Cars from CoreData")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return cars
    }
    
    func updateFlag(carModel: CarModel) {
        let cars = fetchCarsUseNumber(carModel: carModel)
        guard let car = cars.first else { return }
        car.setValue(carModel.activFlag, forKey: "activFlag")
        storage.saveContext()
    }
    
    func getActiveCar() -> Car? {
        let context = storage.mainContext
        var cars: [Car] = []
        do {
            let request = Car.fetchRequest() as NSFetchRequest<Car>
            cars = try context.fetch(request)
            DispatchQueue.main.async {
                print("Fetch active Car from CoreData")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            
        }
        return cars.first { $0.activFlag }
    }
    
    func  deleteAllCars() {
        let context = storage.mainContext
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        if let passes = try? context.fetch(fetchRequest) {
            for pass in passes {
                context.delete(pass)
            }
        }
        storage.saveContext()
    }
    
    func  deleteCar(number: String) {
        guard let context = getContext() else {return}
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        if let cars = try? context.fetch(fetchRequest) {
            for car in cars {
                if car.number == number {
                    context.delete(car)
                }
            }
        }
        do {
            try context.save()
            DispatchQueue.main.async {
            print("Delete Car from CoreData")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func convertModel(coreDataModel: [Car]) -> [CarModel]{
        var carModelArray: [CarModel] = []
        coreDataModel.forEach { car in
            let carModel = CarModel(item: car.item ?? "",
                                    model: car.model ?? "",
                                    number: car.number ?? "",
                                    year: car.year ?? "",
                                    distance: car.distance,
                                    vin: car.vin ?? "",
                                    activFlag: car.activFlag,
                                    fuelType: car.fuelType ?? "")
            carModelArray.append(carModel)
        }
        return carModelArray
    }
      
}
