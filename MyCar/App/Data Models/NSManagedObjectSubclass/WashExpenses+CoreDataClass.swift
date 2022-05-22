//
//  WashExpenses+CoreDataClass.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData

@objc(WashExpenses)
public final class WashExpenses: NSManagedObject {
    
    static var expensesType = ExpensesType.wash
    
    static func makeNewObject(from model: ExpensesModel, in context: NSManagedObjectContext) -> WashExpenses? {
        guard let currentCar = CarRepository().getActiveCar() else { return nil }
        let newObject = WashExpenses(context: context)
        newObject.toCar = currentCar
        newObject.date = model.date
        newObject.price = model.price
        newObject.distance = model.distance
        newObject.comment = model.comment
        
        newObject.updateRelationships(currentCar: currentCar)
        
        return newObject
    }
    
    func updateRelationships(currentCar: Car) {
        currentCar.addToToWash(self)
    }
    
    func removeFromCar(in context: NSManagedObjectContext) {
        toCar?.removeFromToWash(self)
    }
    
}
