//
//  ResultViewController.swift
//  who is that pokemon
//
//  Created by Alejandro Vanegas Rondon on 22/01/24.
//

import UIKit
import Kingfisher

class ResultViewController: UIViewController {
    
    var resultView: ResultView?{
        self.view as? ResultView
    }
    
    var pokemonName: String = ""
    var pokemonImageUrl: String = ""
    var finalScoreData: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultView?.delegate = self
        resultView?.setAnswer(text: "No, es un \(self.pokemonName)")
        resultView?.setFinalScore(text: "Perdiste, tu puntaje final fue \(self.finalScoreData)")
        resultView?.getImage().kf.setImage(with: URL(string: pokemonImageUrl))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

}

extension ResultViewController: ResultViewDelegate {
    func didButtonPressedPlayAgain() {
        self.dismiss(animated: true)
    }
}
