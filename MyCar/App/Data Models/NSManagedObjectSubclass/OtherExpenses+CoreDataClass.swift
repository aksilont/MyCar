//
//  OtherExpenses+CoreDataClass.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData

@objc(OtherExpenses)
public final class OtherExpenses: NSManagedObject {
    
    static var expensesType = ExpensesType.other
    
    static func makeNewObject(from model: ExpensesModel, in context: NSManagedObjectContext) -> OtherExpenses? {
        guard let currentCar = CarRepository().getActiveCar() else { return nil }
        let newObject = OtherExpenses(context: context)
        newObject.toCar = currentCar
        newObject.date = model.date
        newObject.price = model.price
        newObject.distance = model.distance
        newObject.comment = model.comment
        
        newObject.updateRelationships(currentCar: currentCar)
        
        return newObject
    }
    
    func updateRelationships(currentCar: Car) {
        currentCar.addToToOther(self)
    }
    
    func removeFromCar(in context: NSManagedObjectContext) {
        toCar?.removeFromToOther(self)
    }
    
}
