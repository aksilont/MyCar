//
//  FuelExpenses+CoreDataProperties.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData


extension FuelExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FuelExpenses> {
        return NSFetchRequest<FuelExpenses>(entityName: "FuelExpenses")
    }

    @NSManaged public var date: Date?
    @NSManaged public var price: Float
    @NSManaged public var discript: String?
    @NSManaged public var distance: Float
    @NSManaged public var toCar: Car?

}

extension FuelExpenses : Identifiable {

}
