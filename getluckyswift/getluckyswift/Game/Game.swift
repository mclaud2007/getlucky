//
//  Game.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 19.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import Foundation

protocol GameProto {    
    func gameStarted()
    func gameOver()
    func gameEnd()
    
    func getCorrectAnswer()
}

class Game {
    static var shared = Game()
    var sessions: [GameSession]?
    var session: GameSession? {
        if let session = sessions {
            return session.last
        } else {
            return nil
        }
    }
    
    var questions: [Question]?
    var delegate: GameProto?
    
    public func start() {
        // Инициализируем новый пак вопросов
        questions = [Question(text: "Первый вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 100),
                     Question(text: "Второй вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 200),
                     Question(text: "Третий вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 300),
                     Question(text: "Четвертый вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 400),
                     Question(text: "Пятый вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 500)]
        
        if let questions = questions {
            var totalPrice = 0
            
            // Считаем сумму баллов, которые получит пользователь ответив на все вопросы
            for question in questions {
                totalPrice += question.price
            }
            
            let newSession = GameSession(questions: questions.count, answers: 0, current: 0, score: 0, price: totalPrice, over: false);
            
            // Запускаем новую сессию
            if let _ = sessions {
                sessions?.append(newSession)
            } else {
                sessions = [newSession]
            }
            
            // Игра запущена - обработка в делегате
            delegate?.gameStarted()
        }
    }
    
    public func question() -> Question? {
        if let sess = self.session,
            !sess.isGameOver(),
            let questions = questions,
            questions.indices.contains(sess.currentQuestion)
        {
            return questions[sess.currentQuestion]
        } else {
            return nil
        }
    }
    
    public func check(question number: Int){
        if let sess = session,
            !sess.isGameOver()
        {
            if let questions = questions,
                questions.indices.contains(sess.currentQuestion),
                questions[sess.currentQuestion].correct == number
            {
                sess.addScore(price: questions[sess.currentQuestion].price)
                sess.addAnswer()
                
                // Если вопросы еще есть - идем дальше
                if sess.addQuestion() {
                    delegate?.getCorrectAnswer()
                } else {
                    delegate?.gameOver()
                }
                
            } else {
                delegate?.gameOver()
            }
        }
    }
    
    public func total() -> Int {
        return session?.totalScore ?? 0
    }
}
