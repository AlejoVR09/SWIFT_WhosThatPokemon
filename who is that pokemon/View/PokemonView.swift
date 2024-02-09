//
//  PokemonView.swift
//  who is that pokemon
//
//  Created by Alejandro Vanegas Rondon on 19/01/24.
//

import UIKit

protocol PokemonViewDelegate {
    func didButtonPressed(sender: UIButton)
    
}



class PokemonView: UIView {
    var pokemonViewDelegate: PokemonViewDelegate?
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private var optionButtons: [UIButton]!
    @IBOutlet private weak var pokemonImage: UIImageView!
    
    func buttonsProperties(){
        for i in optionButtons {
            i.layer.shadowColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            i.layer.shadowOffset = CGSize(width: 0, height: 2)
            i.layer.shadowRadius = 0
            i.layer.shadowOpacity = 1
            i.layer.cornerRadius = 10
            i.layer.masksToBounds = false
        }
    }
    
    
    
    func setAnswerLabel(text: String){
        answerLabel.text = text
    }
    
    func setScore(text: String){
        scoreLabel.text = text
    }
    
    func getButtons() -> [UIButton] {
        return optionButtons
    }
    
    func getImage() -> UIImageView {
        return pokemonImage
    }
    
    func setTitles1(randomArray: [PokemonModel]){
        for (i, button) in self.getButtons().enumerated() {
            DispatchQueue.main.async {
                button.setTitle(randomArray[i].name.capitalized, for: .normal)
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction private func didPressButton(_ sender: UIButton) {
        self.pokemonViewDelegate?.didButtonPressed(sender: sender)
    }
    
}
