//
//  ExpensesRepository.swift
//  MyCar
//
//  Created by Aksilont on 17.05.2022.
//

import Foundation
import CoreData

typealias ManagedExpensesModel = NSManagedObject & ExpensesModel

protocol ExpensesModel {
    var date: Date? { get set }
    var price: Float { get set }
    var description: String? { get set }
    var distance: Float { get set }
    var toCar: Car? { get set }
}

enum CategoryType {
    case parking
    case wash
    case fix
    case fuel
    case finance
    case other
}

final class ExpensesRepository {
    
    private let storage = CoreDataStack.shared
    
    // TODO: - Сделать сохранение и получение расходов по категориям (перечисления)
    
    func fetchParkingExpenses(completion: @escaping ([ParkingExpenses]) -> ()) {
        fetch(categoryType: ParkingExpenses.self, predicate: nil, completion: completion)
    }
    
    func fetchWashExpenses(completion: @escaping ([WashExpenses]) -> ()) {
        fetch(categoryType: WashExpenses.self, predicate: nil, completion: completion)
    }
    
    func fetchFixExpenses(completion: @escaping ([FixExpenses]) -> ()) {
        fetch(categoryType: FixExpenses.self, predicate: nil, completion: completion)
    }
    
    func fetchFuelExpenses(completion: @escaping ([FuelExpenses]) -> ()) {
        fetch(categoryType: FuelExpenses.self, predicate: nil, completion: completion)
    }
    
    func fetchFinanceExpenses(completion: @escaping ([FinanceExpenses]) -> ()) {
        fetch(categoryType: FinanceExpenses.self, predicate: nil, completion: completion)
    }
    
    func fetchOtherExpenses(completion: @escaping ([OtherExpenses]) -> ()) {
        fetch(categoryType: OtherExpenses.self, predicate: nil, completion: completion)
    }
    
    
    func fetch<T: NSManagedObject>(categoryType: T.Type,
                                   predicate: NSPredicate?,
                                   completion: @escaping ([T]) -> ()) {
        let context = storage.mainContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: categoryType))
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            completion(results)
        } catch let error as NSError {
            print(error.userInfo)
            completion([])
        }
    }
    
    func saveParkingExpenses() -> ParkingExpenses {
        let context = storage.mainContext
        
        let parking = ParkingExpenses(context: context)
        parking.date = Date()
        parking.discript = "test data"
        parking.distance = 1000.32
        parking.price = 123.123
        
        storage.saveContext()
        
        return parking
    }
    
    
}
