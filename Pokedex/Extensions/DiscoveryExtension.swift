//
//  DiscoveryExtension.swift
//  Pokedex
//
//  Created by Laborit on 25/07/21.
//

import UIKit
var pokemons: [Pokemon] = []
//var filteredPokemons: [Pokemon] = []
var selectedPokemon: Pokemon?

extension DiscoveryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPokemons.count
        
    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse cell and cast it as PokemonCell
        let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell
        // Get the Pokemon for this indexPatch
        let pokemon = filteredPokemons[indexPath.row]
        // Get url for pokeimage
        pokemonCell?.setupWithPokemon(pokemon: pokemon)
        
        return pokemonCell!
    }
    
}

extension DiscoveryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = filteredPokemons[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
}

extension DiscoveryViewController: SearchViewDelegate {
    func searchedText(textSearched: String){
        self.filterPokemons(pokemonName: textSearched)
    }
}
