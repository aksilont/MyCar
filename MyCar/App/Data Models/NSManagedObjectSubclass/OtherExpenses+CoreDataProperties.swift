//
//  OtherExpenses+CoreDataProperties.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData


extension OtherExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OtherExpenses> {
        return NSFetchRequest<OtherExpenses>(entityName: "OtherExpenses")
    }

    @NSManaged public var date: Date?
    @NSManaged public var price: Float
    @NSManaged public var discript: String?
    @NSManaged public var distance: Float
    @NSManaged public var toCar: Car?

}

extension OtherExpenses : Identifiable {

}
