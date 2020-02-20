//
//  GameSession.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 19.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import Foundation

class GameSession {
    var totalQuestions: Int = 0
    var answerQuestions: Int = 0
    var currentQuestion: Int = 0
    var totalPrice: Int = 0
    var totalScore: Int = 0
    var gameOver: Bool = false
    var date: Date
    
    init (questions: Int, answers: Int, current: Int, score: Int, price: Int, over: Bool) {
        totalQuestions = questions
        answerQuestions = answers
        currentQuestion = current
        totalPrice = price
        totalScore = 0
        gameOver = over
        date = Date()
    }
    
    public func addScore(price: Int){
        totalScore += price
    }
    
    public func addAnswer(){
        answerQuestions += 1
    }
    
    public func addQuestion() -> Bool {
        if (currentQuestion + 1) <= totalQuestions {
            currentQuestion += 1
            return true
        } else {
            return false
        }
    }
    
    public func isGameOver() -> Bool {
        return gameOver
    }
}
