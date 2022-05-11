//
//  WashExpenses+CoreDataProperties.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData


extension WashExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WashExpenses> {
        return NSFetchRequest<WashExpenses>(entityName: "WashExpenses")
    }

    @NSManaged public var date: Date?
    @NSManaged public var price: Float
    @NSManaged public var discript: String?
    @NSManaged public var distance: Float
    @NSManaged public var toCar: Car?

}

extension WashExpenses : Identifiable {

}
