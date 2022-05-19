//
//  ExpensesRepository.swift
//  MyCar
//
//  Created by Aksilont on 17.05.2022.
//

import Foundation
import CoreData

typealias ManagedExpensesModel = NSManagedObject & ExpensesModelProtocol

protocol ExpensesModelProtocol {
    var date: Date? { get set }
    var price: Float { get set }
    var comment: String? { get set }
    var distance: Float { get set }
    var toCar: Car? { get set }
}

extension ParkingExpenses: ExpensesModelProtocol {}
extension WashExpenses: ExpensesModelProtocol {}
extension FixExpenses: ExpensesModelProtocol {}
extension FuelExpenses: ExpensesModelProtocol {}
extension FinanceExpenses: ExpensesModelProtocol {}
extension OtherExpenses: ExpensesModelProtocol {}

final class ExpensesRepository {
    
    private let storage = CoreDataStack.shared
    
    // MARK: - Общие методы
    
    func getClass(by categoryType: CategoryType) -> ManagedExpensesModel.Type {
        switch categoryType {
        case .parking:
            return ParkingExpenses.self
        case .wash:
            return WashExpenses.self
        case .fix:
            return FixExpenses.self
        case .fuel:
            return FuelExpenses.self
        case .finance:
            return FuelExpenses.self
        case .other:
            return OtherExpenses.self
        }
    }
    
    // MARK: - Получение данных
    
    private func fetch<T: ManagedExpensesModel>(modelType: T.Type,
                                        predicate: NSPredicate?,
                                        limit: Int,
                                        completion: @escaping ([ManagedExpensesModel]) -> ()) {
        guard let currentCar = CarRepository().getActiveCar() else { return }
        
        let context = storage.mainContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: modelType))
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        fetchRequest.fetchLimit = limit
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "toCar == %@", currentCar),
            predicate ?? NSPredicate(value: true)
        ])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let results = try context.fetch(fetchRequest)
            completion(results)
        } catch let error as NSError {
            print(error.userInfo)
            completion([])
        }
    }
    
    func fetch(by categoryType: CategoryType,
               predicate: NSPredicate? = nil,
               limit: Int = 10,
               completion: @escaping (([ManagedExpensesModel]) -> ())) {
        switch categoryType {
        case .parking:
            fetch(modelType: ParkingExpenses.self, predicate: predicate, limit: limit, completion: completion)
        case .wash:
            fetch(modelType: WashExpenses.self, predicate: predicate, limit: limit, completion: completion)
        case .fix:
            fetch(modelType: FixExpenses.self, predicate: predicate, limit: limit, completion: completion)
        case .fuel:
            fetch(modelType: FuelExpenses.self, predicate: predicate, limit: limit, completion: completion)
        case .finance:
            fetch(modelType: FinanceExpenses.self, predicate: predicate, limit: limit, completion: completion)
        case .other:
            fetch(modelType: OtherExpenses.self, predicate: predicate, limit: limit, completion: completion)
        }
    }
    
    func fetch(by categoryType: CategoryType, daysAgo: Int, completion: @escaping (([ManagedExpensesModel]) -> ())) {
        let daysAgo = Date().daysAgo(daysAgo)
        let predicate = NSPredicate(format: "date >= %@", daysAgo as NSDate)
        fetch(by: categoryType, predicate: predicate, completion: completion)
    }
    
    // MARK: - Сохранение данных
    
    func saveExpenses(categoryType: CategoryType,
                      date: Date,
                      price: Float,
                      distance: Float,
                      comment: String) -> ManagedExpensesModel? {
        guard let currentCar = CarRepository().getActiveCar() else { return nil }
        
        let context = storage.mainContext
        
        let entityName = String(describing: getClass(by: categoryType))
        guard var newOjbect = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? ManagedExpensesModel
        else { return nil }
        newOjbect.toCar = currentCar
        newOjbect.date = date
        newOjbect.price = price
        newOjbect.distance = distance
        newOjbect.comment = comment
        
        storage.saveContext()
        return newOjbect
    }
    
    // MARK: - Удаление данных
    
    func deleteExpenses(categoryType: CategoryType) {
        let context = storage.mainContext
        fetch(by: categoryType, limit: .max) { items in
            items.forEach {
                print("Delete \($0)")
                context.delete($0)
            }
        }
        storage.saveContext()
    }
    
}
