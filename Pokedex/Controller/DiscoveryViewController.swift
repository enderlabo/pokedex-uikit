//
//  DiscoveryViewController.swift
//  Pokedex
//
//  Created by Laborit on 25/07/21.
//

import UIKit

class DiscoveryViewController: UIViewController {
    
    @IBOutlet weak var pokemonTable: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    var filteredPokemons: [Pokemon] = []
    var selectedPokemons: Pokemon?
    var pokemons:[Pokemon] = []
    
    override func viewDidLoad() {
        pokemonTable.dataSource = self
        pokemonTable.delegate = self
        searchView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? PokemonDetailViewController {
            detailVC.pokemon = selectedPokemon
        }
    }
        
    override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //TODO updatedUI()
        NetworkManager.shared.getPokemons{ response in
            switch response {
            
            case .success(let pokemons):
                //Todo
//                print(pokemons)
                self.pokemons += pokemons
                self.filteredPokemons = self.pokemons
                self.updateUI()
                break
            case .failed:
                // no action required
                break
                
            }
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.pokemonTable.reloadData()
        }
    }
    
    func filterPokemons(pokemonName: String){
        filteredPokemons = pokemonName.isEmpty ? pokemons :pokemons.filter({pokemon in
            return pokemon.name?.lowercased().contains(pokemonName.lowercased()) ?? false
        })
            
            updateUI()
        }
   
    }//Class

