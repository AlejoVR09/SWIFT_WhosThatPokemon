//
//  ResultView.swift
//  who is that pokemon
//
//  Created by Alejandro Vanegas Rondon on 22/01/24.
//

import UIKit

protocol ResultViewDelegate {
    func didButtonPressedPlayAgain()
}

class ResultView: UIView {
    var delegate: ResultViewDelegate?
   
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    
    func setAnswer(text: String){
        self.answer.text = text
    }
    
    func setFinalScore(text: String){
        self.finalScore.text = text
    }
    
    func getImage() -> UIImageView{
        return self.pokemonImage
    }
    
    @IBOutlet weak var playAgain: UIButton!
    
    @IBAction func playAgainAction(_ sender: Any) {
        self.delegate?.didButtonPressedPlayAgain()
    }
}
