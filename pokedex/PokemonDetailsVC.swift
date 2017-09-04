//
//  PokemonDetailsVC.swift
//  pokedex
//
//  Created by Ahmad Ragab on 9/3/17.
//  Copyright © 2017 Ahmad Ragab. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeLbl.text = ""
        defenseLbl.text = ""
        heightLbl.text = ""
        pokedexIdLbl.text = ""
        weightLbl.text = ""
        baseAttackLbl.text = ""
        evoLbl.text = ""
        
        pokemon.downloadPokemonDetails { 
            self.updateUI()
        }
    }
    
    func updateUI() {
        nameLbl.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        evoLbl.text = pokemon.nextEvolution
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
    }

    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
