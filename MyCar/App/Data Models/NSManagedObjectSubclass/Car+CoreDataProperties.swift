//
//  Car+CoreDataProperties.swift
//  MyCar
//
//  Created by Alex Larin on 10.05.2022.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var activFlag: Bool
    @NSManaged public var distance: Float
    @NSManaged public var fuelType: String?
    @NSManaged public var item: String?
    @NSManaged public var model: String?
    @NSManaged public var number: String?
    @NSManaged public var vin: String?
    @NSManaged public var year: String?
    @NSManaged public var toFinance: NSSet?
    @NSManaged public var toFix: NSSet?
    @NSManaged public var toFuel: NSSet?
    @NSManaged public var toOther: NSSet?
    @NSManaged public var toParking: NSSet?
    @NSManaged public var toWash: NSSet?

}

// MARK: Generated accessors for toFinance
extension Car {

    @objc(addToFinanceObject:)
    @NSManaged public func addToToFinance(_ value: FinanceExpenses)

    @objc(removeToFinanceObject:)
    @NSManaged public func removeFromToFinance(_ value: FinanceExpenses)

    @objc(addToFinance:)
    @NSManaged public func addToToFinance(_ values: NSSet)

    @objc(removeToFinance:)
    @NSManaged public func removeFromToFinance(_ values: NSSet)

}

// MARK: Generated accessors for toFix
extension Car {

    @objc(addToFixObject:)
    @NSManaged public func addToToFix(_ value: FixExpenses)

    @objc(removeToFixObject:)
    @NSManaged public func removeFromToFix(_ value: FixExpenses)

    @objc(addToFix:)
    @NSManaged public func addToToFix(_ values: NSSet)

    @objc(removeToFix:)
    @NSManaged public func removeFromToFix(_ values: NSSet)

}

// MARK: Generated accessors for toFuel
extension Car {

    @objc(addToFuelObject:)
    @NSManaged public func addToToFuel(_ value: FuelExpenses)

    @objc(removeToFuelObject:)
    @NSManaged public func removeFromToFuel(_ value: FuelExpenses)

    @objc(addToFuel:)
    @NSManaged public func addToToFuel(_ values: NSSet)

    @objc(removeToFuel:)
    @NSManaged public func removeFromToFuel(_ values: NSSet)

}

// MARK: Generated accessors for toOther
extension Car {

    @objc(addToOtherObject:)
    @NSManaged public func addToToOther(_ value: OtherExpenses)

    @objc(removeToOtherObject:)
    @NSManaged public func removeFromToOther(_ value: OtherExpenses)

    @objc(addToOther:)
    @NSManaged public func addToToOther(_ values: NSSet)

    @objc(removeToOther:)
    @NSManaged public func removeFromToOther(_ values: NSSet)

}

// MARK: Generated accessors for toParking
extension Car {

    @objc(addToParkingObject:)
    @NSManaged public func addToToParking(_ value: ParkingExpenses)

    @objc(removeToParkingObject:)
    @NSManaged public func removeFromToParking(_ value: ParkingExpenses)

    @objc(addToParking:)
    @NSManaged public func addToToParking(_ values: NSSet)

    @objc(removeToParking:)
    @NSManaged public func removeFromToParking(_ values: NSSet)

}

// MARK: Generated accessors for toWash
extension Car {

    @objc(addToWashObject:)
    @NSManaged public func addToToWash(_ value: WashExpenses)

    @objc(removeToWashObject:)
    @NSManaged public func removeFromToWash(_ value: WashExpenses)

    @objc(addToWash:)
    @NSManaged public func addToToWash(_ values: NSSet)

    @objc(removeToWash:)
    @NSManaged public func removeFromToWash(_ values: NSSet)

}

extension Car : Identifiable {

}
