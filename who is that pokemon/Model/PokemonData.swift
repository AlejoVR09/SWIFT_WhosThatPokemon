//
//  PokemonData.swift
//  who is that pokemon
//
//  Created by Alejandro Vanegas Rondon on 19/01/24.
//

import Foundation

struct PokemonData: Codable {
    var results: [Result]?
}

struct Result: Codable {
    
    let name: String?
    let url: String?
}
