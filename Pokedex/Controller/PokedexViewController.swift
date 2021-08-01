//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Laborit on 31/07/21.
//

import UIKit

class PokedexViewController: UIViewController {

    @IBOutlet weak var PokedexView: SearchView!
    @IBOutlet weak var pokemonTable: UITableView!
    @IBOutlet weak var PokedexTableView: UITableView!
    @IBAction func btnSavePokedex(_ sender: Any) {
    }
    
    var filteredPokemons: [PokemonCD] = []
    var selectedPokemons: Pokemon?
    var pokemons:[PokemonCD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTable.dataSource = self
        pokemonTable.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //load the data from Core Data
        pokemons = CoreDataManager.shared.fetchPokemons() ?? []
        filteredPokemons = pokemons
        updateUI()
    }
    
    func updateUI(){
        pokemonTable.reloadData()
    }
    
    func transitionToDetail() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "detailSegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVc = segue.destination as? PokemonDetailViewController {
            detailVc.pokemon = selectedPokemons
            detailVc.showAddButton = true
        }
    }
    
    func filterPokemons(pokemonName: String) {
            if pokemonName.isEmpty {
                filteredPokemons = pokemons
            } else {
                filteredPokemons = pokemons.filter({ pokemon in
                    return pokemon.name?.lowercased().contains(pokemonName.lowercased()) ?? false
                })
            }
            updateUI()
        }

}

