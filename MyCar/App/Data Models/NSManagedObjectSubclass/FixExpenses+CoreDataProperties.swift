//
//  FixExpenses+CoreDataProperties.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData


extension FixExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FixExpenses> {
        return NSFetchRequest<FixExpenses>(entityName: "FixExpenses")
    }

    @NSManaged public var price: Float
    @NSManaged public var date: Date?
    @NSManaged public var discript: String?
    @NSManaged public var distance: Float
    @NSManaged public var toCar: Car?

}

extension FixExpenses : Identifiable {

}
