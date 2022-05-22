//
//  CarRepository.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//

import UIKit
import CoreData

class CarRepository {
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    // сохранение в CoreData:
    func saveCar(carModel: CarModel) {
        guard let context = getContext(), let entity = NSEntityDescription.entity(forEntityName: "Car", in: context) else {return}
        let carObject = Car(entity: entity, insertInto: context)
        carObject.activFlag = carModel.activFlag
        carObject.number = carModel.number
        carObject.vin = carModel.vin
        carObject.fuelType = carModel.fuelType
        carObject.distance = carModel.distance
        carObject.year = carModel.year
        carObject.model = carModel.model
        carObject.item = carModel.item
        do {
            try context.save()
            DispatchQueue.main.async {
                print("Save One Car in CoreData")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            
        }
    }
    // получение из CoreData:
    func fetchCars() -> [Car]{
        var cars: [Car] = []

        guard let context = getContext() else { return cars }
        do {
            let request = Car.fetchRequest() as NSFetchRequest<Car>
            cars = try context.fetch(request)
            DispatchQueue.main.async {
                print("Fetch Cars from CoreData")
            }
            
        } catch  let error as NSError {
            print(error.localizedDescription)
            
        }
        return cars
    }
    
    func fetchCarsUseNumber (carModel: CarModel) -> [Car] {
        var cars: [Car] = []
        let carNumber = carModel.number

        guard let context = getContext() else { return cars }
        do {
            let request = Car.fetchRequest() as NSFetchRequest<Car>
            let pred = NSPredicate(format: "number CONTAINS %@", carNumber)
            request.predicate = pred
            cars = try context.fetch(request)
            DispatchQueue.main.async {
                print("Fetch Cars from CoreData")
            }
            
        } catch  let error as NSError {
            print(error.localizedDescription)
            
        }
        return cars
        
    }
    
    func upDateFlag(carModel: CarModel) {
        guard let context = getContext() else {return}
        let cars = fetchCarsUseNumber(carModel: carModel)
        let car = cars.first
            do {
                car?.setValue(carModel.activFlag, forKey: "activFlag")
                try context.save()
            } catch  let error as NSError {
                print(error.localizedDescription)
            }
       
    }
    
    func getActiveCar() -> Car? {
        var cars: [Car] = []

        guard let context = getContext() else { return nil }
        do {
            let request = Car.fetchRequest() as NSFetchRequest<Car>
            cars = try context.fetch(request)
            DispatchQueue.main.async {
                print("Fetch active Car from CoreData")
            }
            
        } catch  let error as NSError {
            print(error.localizedDescription)
            
        }
        return cars.first { $0.activFlag }
    }
    
    func  deleteAllCars() {
        guard let context = getContext() else {return}
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        if let passes = try? context.fetch(fetchRequest) {
            for pass in passes {
                context.delete(pass)
            }
        }
        do {
            try context.save()
            DispatchQueue.main.async {
                print("Delete All Cars from Core Data")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
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
        var carModelArray:[CarModel] = []
        coreDataModel.forEach { car in
            let carModel = CarModel(item: car.item ?? "", model: car.model ?? "" , number: car.number ?? "", year: car.year ?? "", distance: car.distance, vin: car.vin ?? "", activFlag: car.activFlag, fuelType: car.fuelType ?? "")
            carModelArray.append(carModel)
        }
        return carModelArray
    }
      
    }
