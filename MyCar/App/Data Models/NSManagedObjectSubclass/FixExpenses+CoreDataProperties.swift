//
//  FixExpenses+CoreDataProperties.swift
//  MyCar
//
//  Created by Aksilont on 18.05.2022.
//
//

import Foundation
import CoreData


extension FixExpenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FixExpenses> {
        return NSFetchRequest<FixExpenses>(entityName: "FixExpenses")
    }

    @NSManaged public var date: Date?
    @NSManaged public var comment: String?
    @NSManaged public var distance: Float
    @NSManaged public var price: Float
    @NSManaged public var toCar: Car?

}

extension FixExpenses : Identifiable {

}
