//
//  Pokemon.swift
//  pokedex
//
//  Created by Ahmad Ragab on 9/2/17.
//  Copyright © 2017 Ahmad Ragab. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolution: String!
    private var _nextEvolutionId: String!
    private var _pokemonURL: String!
    
    var name: String {
        if _name == nil { _name = "" }
        return _name
    }
    
    var pokedexId: Int {
        if _pokedexId == nil { _pokedexId = 0 }
        return _pokedexId
    }
    
    var description: String {
        if _description == nil { _description = "" }
        return _description
    }
    
    var type: String {
        if _type == nil { _type = "" }
        return _type
    }
    
    var defense: String {
        if _defense == nil { _defense = "" }
        return _defense
    }
    
    var height: String {
        if _height == nil { _height = "" }
        return _height
    }
    
    var weight: String {
        if _weight == nil { _weight = "" }
        return _weight
    }
    
    var attack: String {
        if _attack == nil { _attack = "" }
        return _attack
    }
    
    var nextEvolution: String {
        if _nextEvolution == nil { _nextEvolution = "" }
        return _nextEvolution
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil { _nextEvolutionId = "" }
        return _nextEvolutionId
    }
    
    var pokemonURL: String {
        if _pokemonURL == nil { _pokemonURL = "" }
        return _pokemonURL
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadCompleted) {
        
        Alamofire.request(self.pokemonURL).responseJSON { (response) in
            
            if let details = response.value as? Dictionary<String, Any> {
                
                // Name
                if let pokeName = details["name"] as? String {
                    self._name = pokeName
                }
                
                // Defense
                if let defense = details["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                // Height
                if let height = details["height"] as? String {
                    self._height = height
                }
                
                // Weight
                if let weight = details["weight"] as? String {
                    self._weight = weight
                }
                
                // Attack
                if let attack = details["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                // Type
                if let types = details["types"] as? [Dictionary<String, Any>] {
                    
                    for pokeType in types {
                        
                        if let typeName = pokeType["name"] as? String {
                            if self._type != nil {
                                self._type = "\(self.type.capitalized)/\(typeName.capitalized)"
                            } else {
                                self._type = "\(typeName.capitalized)"
                            }
                        }
                        
                    }
                }
                
                // Next Evolution
                if let evolutions = details["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0 {
                    
                    if let nextEvoURL = evolutions[0]["resource_uri"] as? String {
                        
                        if let level = evolutions[0]["level"] as? Int {
                            
                            if let nextEvoPokeName = evolutions[0]["to"] as? String {
                                
                                var nextPoke = nextEvoURL.replacingOccurrences(of: "api/v1/pokemon/", with: "")
                                nextPoke = nextPoke.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId  = nextPoke
                                
                                if self._nextEvolutionId != nil {
                                    self._nextEvolution = "Next Evolution: \(nextEvoPokeName) - LVL \(level)"
                                } else {
                                    self._nextEvolution = "Next Evolution: None"
                                }
                                
                            }
                        }
                    }
                }
                
                // Description
                if let descriptions = details["descriptions"] as? [Dictionary<String, Any>], descriptions.count > 0 {
                    
                    if let descriptionURL = descriptions[0]["resource_uri"] as? String {
                        
                        let url = "\(BASE_URL)\(descriptionURL)"
                        Alamofire.request(url).responseJSON(completionHandler: { (descriptionResponse) in
                            if let descs = descriptionResponse.value as? Dictionary<String, Any> {
                                
                                if let desc = descs["description"] as? String {
                                    self._description = desc.replacingOccurrences(of: "POKMON", with: "Pokemon").capitalized
                                }
                            }
                            
                            completed()
                        })
                    }
                }
            }
            completed()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
