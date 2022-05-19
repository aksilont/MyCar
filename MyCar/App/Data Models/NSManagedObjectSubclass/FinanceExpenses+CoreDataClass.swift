//
//  FinanceExpenses+CoreDataClass.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData

@objc(FinanceExpenses)
public final class FinanceExpenses: NSManagedObject {
    
    static var expensesType = ExpensesType.finance
    
    static func makeNewObject(from model: ExpensesModel, in context: NSManagedObjectContext) -> FinanceExpenses? {
        guard let currentCar = CarRepository().getActiveCar() else { return nil }
        let newObject = FinanceExpenses(context: context)
        newObject.toCar = currentCar
        newObject.date = model.date
        newObject.price = model.price
        newObject.distance = model.distance
        newObject.comment = model.comment
        
        newObject.updateRelationships(currentCar: currentCar)
        
        return newObject
    }
    
    func updateRelationships(currentCar: Car) {
        currentCar.addToToFinance(self)
    }
    
}
