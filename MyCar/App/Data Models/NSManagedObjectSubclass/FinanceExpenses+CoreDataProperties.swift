//
//  FinanceExpenses+CoreDataProperties.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData


extension FinanceExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinanceExpenses> {
        return NSFetchRequest<FinanceExpenses>(entityName: "FinanceExpenses")
    }

    @NSManaged public var date: Date?
    @NSManaged public var price: Float
    @NSManaged public var descript: String?
    @NSManaged public var distance: Float
    @NSManaged public var toCar: Car?

}

extension FinanceExpenses : Identifiable {

}
