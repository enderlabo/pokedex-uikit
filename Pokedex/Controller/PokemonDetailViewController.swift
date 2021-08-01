//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Laborit on 24/07/21.
//

import UIKit
import SDWebImage
import Toaster

class PokemonDetailViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelOrder: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var vStats: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var VStack: UIStackView!
    var pokemon: Pokemon?
    var showAddButton: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        //MARK: - Setting Labels
        addButton.isHidden = showAddButton
        let type = pokemon?.types?.first?.type?.name ?? ""
        labelName.text = pokemon?.name?.uppercased()
        labelOrder.text = "#\(pokemon?.order ?? 0)"
        labelType.text = type
        vStats.backgroundColor = UIColor.TypeColors.getColor(fromType: type)
        mainView.backgroundColor = UIColor.TypeColors.getColor(fromType: type)
        //MARK: - Setting up our image
        let url = URL(string: pokemon?.sprites?.frontDefault ?? "")
        
        if let unwrappedURL = url {
            imgPokemon.sd_setImage(with: unwrappedURL, completed: nil)
        }
        
        //MARK: - Setup VStack
        pokemon?.stats?.forEach { stat in
            let statElement = StatElement(stat.stat?.name ?? "", stat.baseStat ?? 0)
            VStack.addArrangedSubview(statElement)
        }
        
        //MARK: - Setting View Stats
        vStats.roundCorners(withRadius: 30)
    }
    
    @IBAction func addButtonTap(_ sender: Any) {
        if let pokemon = self.pokemon {
            CoreDataManager.shared.savePokemonInPokedex(pokemon: pokemon)
        }
        let toast = Toast(text: "Pokemon Saved", duration: Delay.short)
        toast.show()
    }
}

class StatElement: UIView {
   convenience init(_ name: String, _ power: Int) {
    self.init()
    commonInitializer(name: name, power: power)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func commonInitializer(name: String, power: Int){
        //Add a horizontalView
        let HStack = UIStackView()
        HStack.axis = .horizontal
        HStack.distribution = .fillEqually
        HStack.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
   
    
        // Create an UILabel for the Name
        let lblName = UILabel()
        lblName.text = name.uppercased()
        lblName.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        lblName.textColor = .black
        
        HStack.addArrangedSubview(lblName)
        // Create an UILabel for the power
        let lblPower = UILabel()
        lblPower.text = String(power)
        lblPower.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        lblPower.textAlignment = .right
        
        HStack.addArrangedSubview(lblPower)
        
        //adding it to the subView
        self.addSubview(HStack)
        self.backgroundColor = .gray
        self.roundCorners(withRadius: 15)
    }
}
