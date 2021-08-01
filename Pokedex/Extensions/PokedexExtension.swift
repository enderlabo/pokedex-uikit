//
//  PokedexExtension.swift
//  Pokedex
//
//  Created by Laborit on 31/07/21.
//

import UIKit
var filteredPokemons: [PokemonCD] = []
extension PokedexViewController: UITableViewDataSource {
    
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

extension PokedexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonName = self.filteredPokemons[indexPath.row].name ?? ""
        NetworkManager.shared.getPokemon(withName: pokemonName){ response in
            switch response {
            case .success(let pokemons):
                self.selectedPokemons = pokemons.first
                break
                
            case .failed:
                print("error")
            }
        }
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    //Delete one item with gesture
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pokemonId = filteredPokemons[indexPath.row].id
        if editingStyle == .delete {
            filteredPokemons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.shared.deletePokeminInPokedex(withId: Int(pokemonId))
        }
    }
    
}

extension PokedexViewController: SearchViewDelegate {
  
    func searchedText(textSearched: String){
        self.filterPokemons(pokemonName: textSearched)
    }
}
