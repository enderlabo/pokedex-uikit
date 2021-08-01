//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Laborit on 24/07/21.
//

import Foundation

struct Pokemon2 {
    let name: String
    let order: Int
    let type: String
    let stat: [(name: String, power: Int)]
    let image: String
   
}

//struct MockDataSource {
//    static let pokemon: Pokemon2 = Pokemon2(name: "Charizard", order: 6, type: "Fire", stat: [("Hp", 600 ), ("Attack", 95), ("Defend", 10)], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")
//
//    static let pokemon2: Pokemon = Pokemon(name: "Scyther", order: 26, type: "Insect", stat: [("Hp", 100 ), ("Attack", 50), ("Defend", 10)], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/123.png")
//
//    static let pokemon3: Pokemon = Pokemon(name: "Gengar", order: 94, type: "Ghost", stat: [("Hp", 100 ), ("Attack", 85), ("Defend", 10)], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png")
//
//    static let pokemon4: Pokemon = Pokemon(name: "Dragonite", order: 149, type: "Dragon", stat: [("Hp", 700 ), ("Attack", 100), ("Defense", 10)], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/149.png")
//
//    static let pokemons = [ pokemon, pokemon2, pokemon3, pokemon4]
//}


