//
//  ExpensesRepository.swift
//  MyCar
//
//  Created by Aksilont on 17.05.2022.
//

import Foundation
import CoreData

protocol ExpensesObjectProtocol {
    static var expensesType: ExpensesType { get }
    var date: Date? { get set }
    var price: Float { get set }
    var comment: String? { get set }
    var distance: Float { get set }
    var toCar: Car? { get set }
    static func makeNewObject(from model: ExpensesModel, in context: NSManagedObjectContext) -> Self?
}

extension ParkingExpenses: ExpensesObjectProtocol {}
extension WashExpenses: ExpensesObjectProtocol {}
extension FixExpenses: ExpensesObjectProtocol {}
extension FuelExpenses: ExpensesObjectProtocol {}
extension FinanceExpenses: ExpensesObjectProtocol {}
extension OtherExpenses: ExpensesObjectProtocol {}

typealias ManagedExpensesObject = NSManagedObject & ExpensesObjectProtocol

final class ExpensesRepository {
    
    private let storage = CoreDataStack.shared
    private let carRepository = CarRepository()
    
    // MARK: - Общие методы
    
    private func getClass(by categoryType: ExpensesType) -> ManagedExpensesObject.Type {
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
    
    private func buildExpensesModel(_ expensesObject: ManagedExpensesObject) -> ExpensesModel {
        let expensesType = type(of: expensesObject).expensesType
        return ExpensesModel(expensesType: expensesType,
                             date: expensesObject.date ?? Date(),
                             price: expensesObject.price,
                             distance: expensesObject.distance,
                             comment: expensesObject.comment ?? "")
    }
    
    // MARK: - Получение данных
    
    private func fetch<T: ManagedExpensesObject>(modelType: T.Type,
                                                 predicate: NSPredicate?,
                                                 limit: Int,
                                                 completion: @escaping ([T]) -> ()) {
        guard let currentCar = carRepository.getActiveCar() else { return }
        
        let context = storage.mainContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: modelType))
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        fetchRequest.fetchLimit = limit
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "toCar = %@", currentCar),
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
    
    private func fetch(by expensesType: ExpensesType,
               predicate: NSPredicate? = nil,
               limit: Int = 10,
               completion: @escaping (([ManagedExpensesObject]) -> ())) {
        switch expensesType {
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
    
    func fetchExpenses(by expensesType: ExpensesType,
                       predicate: NSPredicate? = nil,
                       limit: Int = 10,
                       completion: @escaping (([ExpensesModel]) -> ())) {
        fetch(by: expensesType, predicate: predicate, limit: limit) { [unowned self] items in
            let models = items.compactMap { buildExpensesModel($0) }
            completion(models)
        }
    }
    
    func fetchExpenses(use model: ExpensesModel,
                       completion: @escaping (([ManagedExpensesObject]) -> ())) {
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "date = %@", model.date as NSDate),
            NSPredicate(format: "price = %f", model.price),
            NSPredicate(format: "distance = %f", model.distance),
            NSPredicate(format: "comment = %@", model.comment)
        ])
        fetch(by: model.expensesType, predicate: predicate, completion: completion)
    }
    
    // MARK: - Сохранение данных
    
    func saveExpenses(model: ExpensesModel) {
        let context = storage.mainContext
        let _ = getClass(by: model.expensesType).makeNewObject(from: model, in: context)
        storage.saveContext()
    }
    
    // MARK: - Удаление данных
    
    func deleteExpenses(model: ExpensesModel) {
        let context = storage.mainContext
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "date = %@", model.date as NSDate),
            NSPredicate(format: "price = %f", model.price),
            NSPredicate(format: "distance = %f", model.distance),
            NSPredicate(format: "comment = %@", model.comment)
        ])
        fetch(by: model.expensesType, predicate: predicate, limit: .max) { items in
            items.forEach {
                print("Delete \($0)")
                context.delete($0)
            }
        }
        storage.saveContext()
    }
    
    func deleteAllExpenses() {
        let context = storage.mainContext
        for expensesType in ExpensesType.allCases {
            fetch(by: expensesType, limit: .max) { items in
                items.forEach {
                    print("Delete \($0)")
                    context.delete($0)
                }
            }
        }
        storage.saveContext()
    }
    
}
