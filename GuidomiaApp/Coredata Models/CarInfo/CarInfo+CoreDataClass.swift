//
//  CarInfo+CoreDataClass.swift
//  GuidomiaApp
//
//  Created by GSS on 2021-04-26.
//
//

import Foundation
import CoreData

@objc(CarInfo)
public class CarInfo: NSManagedObject, Codable {
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(customerPrice, forKey: .customerPrice)
            try container.encode(make , forKey: .make)
            try container.encode(rating , forKey: .rating)
            try container.encode(model, forKey: .model)
            try container.encode(marketPrice , forKey: .marketPrice)
            try container.encode(consList , forKey: .consList)
            
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
              let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "CarInfo", in: managedObjectContext)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.customerPrice = try values.decode(String.self, forKey: .customerPrice)
            self.make  = try values.decode(String.self, forKey: .make)
            self.rating = try values.decode(Int32.self, forKey: .rating)
            self.model = try values.decode(String.self, forKey: .model)
            self.marketPrice = try values.decode(String.self, forKey: .marketPrice)
            self.prosList = try values.decode([String].self, forKey: .prosList)
            self.consList = try values.decode([String].self, forKey: .consList)
        } catch {
            print ("error")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case customerPrice = "customerPrice"
        case make = "make"
        case rating = "rating"
        case model = "model"
        case marketPrice = "marketPrice"
        case prosList = "prosList"
        case consList = "consList"
        
    }
    
}

// Used for applying Codable to NSManaged Core Data entities
extension CodingUserInfoKey{
    static let context = CodingUserInfoKey(rawValue: "context")
}
