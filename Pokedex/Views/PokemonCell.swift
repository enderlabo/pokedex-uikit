//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Laborit on 25/07/21.
//

import UIKit

class PokemonCell: UITableViewCell {


    @IBOutlet weak var view: UIView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var typePokemon: UILabel!
    @IBOutlet weak var numberList: UILabel!
    @IBOutlet weak var label: UIImageView!
    @IBOutlet weak var orderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWithPokemon(pokemon: Pokemon)  {
        let type = pokemon.types?.first?.type?.name ?? ""
        //move all this in method on PokemonCell.swift
        let imageUrl = URL(string: pokemon.sprites?.frontDefault ?? "")
        
        pokemonName.text = pokemon.name
        typePokemon.text = type
        label?.sd_setImage(with: imageUrl, completed: nil)
        orderLabel.text = String("#\(pokemon.order ?? 0)")
        view.backgroundColor = UIColor.TypeColors.getColor(fromType: type )
    }
    
    //load data from core data
    func setupWithPokemon(pokemon: PokemonCD)  {
        let type = pokemon.type
        //move all this in method on PokemonCell.swift
        let imageUrl = URL(string: pokemon.image ?? "")
        
        pokemonName.text = pokemon.name
        label?.sd_setImage(with: imageUrl, completed: nil)
        typePokemon.text = type
        numberList.text = String("#\(pokemon.id)")
        view.backgroundColor = UIColor.TypeColors.getColor(fromType: type ?? "" )
    }

}
