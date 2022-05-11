//
//  ParkingExpenses+CoreDataProperties.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData


extension ParkingExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ParkingExpenses> {
        return NSFetchRequest<ParkingExpenses>(entityName: "ParkingExpenses")
    }

    @NSManaged public var date: Date?
    @NSManaged public var price: Float
    @NSManaged public var discript: String?
    @NSManaged public var distance: Float
    @NSManaged public var toCar: Car?

}

extension ParkingExpenses : Identifiable {

}
