//
//  PokemonManager.swift
//  who is that pokemon
//
//  Created by Alejandro Vanegas Rondon on 19/01/24.
//

import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel])
    func didFailWithError(error: Error)
}

struct PokemonManager {
    var delegate: PokemonManagerDelegate?
    
    let url: String = "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0"
    
    
    func fetchPokemon(){
        self.perfomRequest(with: url)
    }
    
    private func perfomRequest(with urlString: String){
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){ data, response, error in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                }
                
                if let data = data {
                    if let pokemon = self.parseJSON(pokemonData: data){
                        self.delegate?.didUpdatePokemon(pokemons: pokemon)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(pokemonData: Data) -> [PokemonModel]?{
        do{
            let decodeData = try JSONDecoder().decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map{
                PokemonModel(name: $0.name ?? "", imageURL: $0.url ?? "")
            }
            return pokemon
        }catch {
            return nil
        }
    }
}
