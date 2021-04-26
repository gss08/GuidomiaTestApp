//
//  CarInfo+CoreDataProperties.swift
//  GuidomiaApp
//
//  Created by GSS on 2021-04-26.
//
//

import Foundation
import CoreData


extension CarInfo {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CarInfo> {
        return NSFetchRequest<CarInfo>(entityName: "CarInfo")
    }

    @NSManaged public var customerPrice: Int16
    @NSManaged public var make: String?
    @NSManaged public var rating: Int32
    @NSManaged public var model: String?
    @NSManaged public var marketPrice: Int16
    @NSManaged public var prosList: [String]?
    @NSManaged public var consList: [String]?

}

extension CarInfo : Identifiable {

}
