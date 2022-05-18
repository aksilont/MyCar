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
    var comment: String? { get set }
    var distance: Float { get set }
    var toCar: Car? { get set }
}

extension ParkingExpenses: ExpensesModel {}
extension WashExpenses: ExpensesModel {}
extension FixExpenses: ExpensesModel {}
extension FuelExpenses: ExpensesModel {}
extension FinanceExpenses: ExpensesModel {}
extension OtherExpenses: ExpensesModel {}

enum CategoryType {
    case parking
    case wash
    case fix
    case fuel
    case finance
    case other
}

enum Period {
    case year
    case month
    case week
    case day
}

final class ExpensesRepository {
    
    private let storage = CoreDataStack.shared
    
    // MARK: - Получение данных
    
    func fetch<T: ManagedExpensesModel>(modelType: T.Type,
                                        predicate: NSPredicate?,
                                        limit: Int = .max,
                                        completion: @escaping ([ManagedExpensesModel]) -> ()) {
        let context = storage.mainContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: modelType))
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        fetchRequest.fetchLimit = limit
        fetchRequest.predicate = predicate
        
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
               limit: Int = .max,
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
    
    func fetchLast10Expenses(by categoryType: CategoryType, completion: @escaping (([ManagedExpensesModel]) -> ())) {
        fetch(by: categoryType, limit: 10, completion: completion)
    }
    
    func fetchExpenses(by categoryType: CategoryType, dayAgo: Int, completion: @escaping (([ManagedExpensesModel]) -> ())) {
        let tenDayAgo = Date().dayAgo(dayAgo)
        let predicate = NSPredicate(format: "date >= %@", tenDayAgo as NSDate)
        fetch(by: categoryType, predicate: predicate, completion: completion)
    }
    
    // MARK: - Сохранение данных
    
    func saveParkingExpenses() {
        let context = storage.mainContext
        
        for _ in (1...50) {
            let parking = ParkingExpenses(context: context)
            parking.date = Date() - Double(Int.random(in: 86400...1000000))
            parking.comment = "\(parking.date ?? Date())"
            parking.distance = Float(Int.random(in: 100...500000) / 100)
            parking.price = Float(Int.random(in: 100...500000) / 100)
        }
        
        storage.saveContext()
    }
    
    // MARK: - Удаление данных
    
    func deleteExpenses() {
        let context = storage.mainContext
        fetch(by: .parking) { items in
            items.forEach {
                print("Delete \($0)")
                context.delete($0)
            }
        }
        storage.saveContext()
    }
    
}
