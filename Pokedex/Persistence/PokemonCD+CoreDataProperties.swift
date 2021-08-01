//
//  PokemonCD+CoreDataProperties.swift
//  
//
//  Created by Laborit on 31/07/21.
//
//

import Foundation
import CoreData


extension PokemonCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonCD> {
        return NSFetchRequest<PokemonCD>(entityName: "PokemonCD")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var stat: Int64
    @NSManaged public var type: String?

}
