//
//  FixExpenses+CoreDataClass.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData

@objc(FixExpenses)
public final class FixExpenses: NSManagedObject {
    
    static var expensesType = ExpensesType.fix
    
    static func makeNewObject(from model: ExpensesModel, in context: NSManagedObjectContext) -> FixExpenses? {
        guard let currentCar = CarRepository().getActiveCar() else { return nil }
        let newObject = FixExpenses(context: context)
        newObject.toCar = currentCar
        newObject.date = model.date
        newObject.price = model.price
        newObject.distance = model.distance
        newObject.comment = model.comment
        
        newObject.updateRelationships(currentCar: currentCar)
        
        return newObject
    }
    
    func updateRelationships(currentCar: Car) {
        currentCar.addToToFix(self)
    }
    
}
