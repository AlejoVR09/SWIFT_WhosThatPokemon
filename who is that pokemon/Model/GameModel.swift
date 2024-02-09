//
//  GameModel.swift
//  who is that pokemon
//
//  Created by Alejandro Vanegas Rondon on 19/01/24.
//

import Foundation

struct GameModel {
    var score: Int = 0
    
    mutating func checkAnswer(_ userAnswer: String, correctAnswer: String) -> Bool {
        if userAnswer.lowercased() == correctAnswer.lowercased() {
            self.score += 1
            return true
        }
        return false
    }
    
    func getScore() -> Int{
        return self.score
    }
    
    mutating func setScore(score: Int){
        self.score = score
    }
}
