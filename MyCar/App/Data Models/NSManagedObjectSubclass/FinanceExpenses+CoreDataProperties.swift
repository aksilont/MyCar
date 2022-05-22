//
//  FinanceExpenses+CoreDataProperties.swift
//  MyCar
//
//  Created by Aksilont on 18.05.2022.
//
//

import Foundation
import CoreData


extension FinanceExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinanceExpenses> {
        return NSFetchRequest<FinanceExpenses>(entityName: "FinanceExpenses")
    }

    @NSManaged public var date: Date?
    @NSManaged public var comment: String?
    @NSManaged public var distance: Float
    @NSManaged public var price: Float
    @NSManaged public var toCar: Car?

}

extension FinanceExpenses : Identifiable {

}
