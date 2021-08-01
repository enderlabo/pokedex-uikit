//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by Laborit on 31/07/21.
//

import Foundation

struct PokemonResponse: Decodable {
    let count: Int?
    let next: String?
    let results: [Results]
}

struct Results: Decodable {
    let name: String?
    let url: String?
}
// In case parse an empty model
extension PokemonResponse {
    init() {
        self.count = 0
        self.next = ""
        self.results = []
    }
}
