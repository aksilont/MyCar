//
//  ParkingExpenses+CoreDataClass.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData

@objc(ParkingExpenses)
public final class ParkingExpenses: NSManagedObject {

    static var expensesType = ExpensesType.parking
    
    static func makeNewObject(from model: ExpensesModel, in context: NSManagedObjectContext) -> ParkingExpenses? {
        guard let currentCar = CarRepository().getActiveCar() else { return nil }
        let newObject = ParkingExpenses(context: context)
        newObject.toCar = currentCar
        newObject.date = model.date
        newObject.price = model.price
        newObject.distance = model.distance
        newObject.comment = model.comment
        
        newObject.updateRelationships(currentCar: currentCar)
        
        return newObject
    }
    
    func updateRelationships(currentCar: Car) {
        currentCar.addToToParking(self)
    }
    
}
