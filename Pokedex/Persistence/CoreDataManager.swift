//
//  CoreDataManager.swift
//  Pokedex
//
//  Created by Laborit on 31/07/21.
//

import

protocol CoreDataCrudProtocol {
    func savePokemonInPokedex(pokemon: Pokemon)
}

final class CoreDataManager{
    static let shared = CoreDataManager()
    
    func savePokemonInPokedex(pokemon: Pokemon) {
        //interact with coreData along their classes
        guard let appDelegate = UIApplication
        //1
        let managedContext = appDelegate.persistent
    }
}
