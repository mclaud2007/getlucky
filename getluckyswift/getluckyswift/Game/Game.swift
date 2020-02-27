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

enum QuestionShowType {
    case normal
    case random
}

class Game {
    static var shared = Game()
    private let recordCaretaker = GameCaretaker()
    private let usersQuestionCaretaker = UsersQuestionsCaretaker()
    
    var sessions: [GameSession]? {
        didSet {
            if let sessions = self.sessions {
                do {
                    try recordCaretaker.saveGame(sessions)
                } catch {
                    print("Can't save sessions")
                }
            }
        }
    }
    
    var session: GameSession? {
        if let session = sessions {
            return session.last
        } else {
            return nil
        }
    }
    
    // Предустановленные вопросы
    var questions: [Question]?
    
    // Пользовательские вопросы
    var userQuestions: [UsersQuestions] {
        didSet {
            if self.userQuestions.count > 0 {
                do {
                    try usersQuestionCaretaker.save(self.userQuestions)
                } catch {
                    print("Can't save users question")
                }
            }
        }
    }
    
    var delegate: GameProto?
    
    // Настройка отображения вопросов
    var questionShowType: QuestionShowType = .normal
    
    // Текущая стратегия отображения вопросов, в зависимости от настроек
    var showQuestionStrategy: ShowQuestionStrategy {
        switch self.questionShowType {
        case .random:
            return RandomStrategy()
        default:
            return NormalStrategy()
        }
    }
    
    private init () {
        // Пытаемся восстановить сессии
        do {
            self.sessions = try recordCaretaker.loadGame()
        } catch {
            print("Can't load game sessions")
        }
        
        // По-умолчанию пользовательские вопросы пустые
        userQuestions = []
        
        // А также пытаемся восстановить пользовательские вопросы
        do {
            self.userQuestions = try usersQuestionCaretaker.load()
        } catch {
            print("Can't load users questions")
        }
    }
    
    public func start() {
        // Инициализируем новый пак вопросов
        var initQuestions = [Question(text: "Первый вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 100),
                     Question(text: "Второй вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 200),
                     Question(text: "Третий вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 300),
                     Question(text: "Четвертый вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 400),
                     Question(text: "Пятый вопрос", answers: ["Да", "Нет", "Не знаю", "Может быть"], correct: 3, price: 500)]
        
        // Если у нас есть пользовательские вопросы - добавим их к предустановленным
        if userQuestions.count > 0 {
            initQuestions = initQuestions + userQuestions
        }
        
        // Перемещаем полученные вопросы
        questions = showQuestionStrategy.shuffle(initQuestions)
        
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
