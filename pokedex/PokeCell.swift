//
//  PokeCell.swift
//  pokedex
//
//  Created by Ahmad Ragab on 9/2/17.
//  Copyright © 2017 Ahmad Ragab. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        pokeLbl.text = self.pokemon.name.capitalized
        pokeImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
