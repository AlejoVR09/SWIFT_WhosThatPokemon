//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit
import Kingfisher

class PokemonViewController: UIViewController {
    
    lazy var pokemonManager: PokemonManager = PokemonManager()
    lazy var imageManager: ImageManager = ImageManager()
    lazy var gameModel: GameModel = GameModel()	
    
    var randomPokemons: [PokemonModel] = [] {
        didSet{
            pokemonView?.setTitles1(randomArray: randomPokemons)
        }
    }
    var correctName: String = ""
    var correctImage: String = ""
    
    var pokemonView: PokemonView? {
        self.view as? PokemonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonView?.pokemonViewDelegate = self
        pokemonView?.buttonsProperties()
        pokemonView?.setAnswerLabel(text: "")
        pokemonView?.setScore(text: "Puntaje: \(gameModel.getScore())")
        pokemonManager.delegate = self
        pokemonManager.fetchPokemon()
        imageManager.delegate = self
        
    }
}

extension PokemonViewController: PokemonViewDelegate {
    func didButtonPressed(sender: UIButton) {
        guard
            let userAnswer = sender.title(for: .normal)
        else{
            return
        }
        
        if gameModel.checkAnswer(userAnswer, correctAnswer: correctName){
            pokemonView?.setAnswerLabel(text: "Si, es un \(correctName.capitalized)")
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.layer.borderWidth = 2
            if let url = URL(string: correctImage){
                pokemonView?.getImage().kf.setImage(with: url)
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) {
                timer in
                self.pokemonManager.fetchPokemon()
                self.pokemonView?.setAnswerLabel(text: "")
                sender.layer.borderWidth = 0
            }
            pokemonView?.setScore(text: "\(gameModel.getScore())")
        }
        else{
            /*
            pokemonView?.setAnswerLabel(text: "No, es un \(correctName.capitalized)")
            sender.layer.borderColor = UIColor.systemRed.cgColor
            sender.layer.borderWidth = 2
            if let url = URL(string: correctImage){
                pokemonView?.getImage().kf.setImage(with: url)
            }
            
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) {
                
                timer in
                self.pokemonManager.fetchPokemon()
                self.pokemonView?.setAnswerLabel(text: "")
                self.gameModel.setScore(score: 0)
                self.pokemonView?.setScore(text: "\(self.gameModel.getScore())")
                sender.layer.borderWidth = 0
            }
            */
            self.performSegue(withIdentifier: "goToResults", sender: self)
        }
    }
    
    func reset(){
        self.pokemonManager.fetchPokemon()
        self.pokemonView?.setAnswerLabel(text: "")
        self.gameModel.setScore(score: 0)
        self.pokemonView?.setScore(text: "\(self.gameModel.getScore())")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destination = segue.destination as? ResultViewController
            destination?.finalScoreData = gameModel.getScore()
            destination?.pokemonName = correctName
            destination?.pokemonImageUrl = correctImage
            self.reset()
        }
    }
}

extension PokemonViewController: ImageManagerDelegate {
    func didImageFailWithError(error: Error) {
        print(error)
    }
    
    func didImageUpdate(image: ImageModel) {
        correctImage = image.imageUrl
        DispatchQueue.main.async { [self] in
            if let url = URL(string: correctImage) {
                if let pokemonImg = pokemonView?.getImage(){
                    let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
                    pokemonImg.kf.setImage(
                        with: url,
                        options: [
                            .processor(effect)
                        ]
                    )
                }
            }
        }
    }
}

extension PokemonViewController: PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        randomPokemons = pokemons.choose(4)
        let chosePokemon = randomPokemons[Int.random(in: 0...3)]
        correctName = chosePokemon.name
        let imageUrl = chosePokemon.imageURL
        imageManager.callFetch(url: imageUrl)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

extension Collection {
    func choose(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
