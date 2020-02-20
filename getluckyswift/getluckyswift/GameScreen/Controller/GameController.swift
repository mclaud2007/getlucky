//
//  GameController.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 18.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var textQuestion: UILabel!
    @IBOutlet weak var buttonFirstAnswer: UIButton!
    @IBOutlet weak var buttonSecondAnswer: UIButton!
    @IBOutlet weak var buttonThirdAnswer: UIButton!
    @IBOutlet weak var buttonFourthAnswer: UIButton!
    @IBOutlet weak var labelGameOver: UILabel!
    @IBOutlet weak var buttonStartNewGame: UIButton!
    @IBOutlet weak var textGameScore: UILabel!
    
    // MARK: Properties
    var gameService = Game.shared
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameService.delegate = self
        
        // Стартуем новую игру (в случае успеха продолжение в делегате)
        gameService.start()
    }
    
    // MARK: Buttons
    @IBAction func startNewGameClicked(_ sender: Any) {
        // Стартуем новую игру
        // (в случае успеха продолжение в делегате)
        gameService.start()
    }
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        gameService.check(question: 1)
    }
    
    @IBAction func secondButtonClicked(_ sender: Any) {
        gameService.check(question: 2)
    }
    
    @IBAction func thirdButtonClicked(_ sender: Any) {
        gameService.check(question: 3)
    }
    
    
    @IBAction func fourthButtonClicked(_ sender: Any) {
        gameService.check(question: 4)
    }
    
    // MARK: Answers and question
    fileprivate func checkAnswer(answer num: Int) {
        gameService.check(question: num)
    }
    
    fileprivate func loadQuestion(question: Question){
        textQuestion.text = question.text
        buttonFirstAnswer.setTitle(question.answers[0], for: .normal)
        buttonSecondAnswer.setTitle(question.answers[1], for: .normal)
        buttonThirdAnswer.setTitle(question.answers[2], for: .normal)
        buttonFourthAnswer.setTitle(question.answers[3], for: .normal)
    }
    
    func initGameScreen () {
        labelGameOver.isHidden = true
        buttonStartNewGame.isHidden = true
        textGameScore.isHidden = true
        
        // Показываем вопрос и кнопки ответа
        textQuestion.isHidden = false
        buttonFirstAnswer.isHidden = false
        buttonSecondAnswer.isHidden = false
        buttonThirdAnswer.isHidden = false
        buttonFourthAnswer.isHidden = false
    }
}

extension GameController: GameProto {
    func gameStarted() {
        if let question = Game.shared.question() {
            // Сбросим все контролы к значениям по-умолчанию
            initGameScreen()
            
            // Заполняем контроллы вопросом
            loadQuestion(question: question)
        } else {
            // Такого не должно быть на старте игры
            self.gameEnd()
        }
    }
    
    func gameOver() {
        labelGameOver.text = "GAME OVER"
        labelGameOver.isHidden = false
        buttonStartNewGame.isHidden = false
        
        textGameScore.text = "Your score is: \(String(Game.shared.total()))"
        textGameScore.isHidden = false
        
        // Показываем вопрос и кнопки ответа
        textQuestion.isHidden = true
        buttonFirstAnswer.isHidden = true
        buttonSecondAnswer.isHidden = true
        buttonThirdAnswer.isHidden = true
        buttonFourthAnswer.isHidden = true
    }
    
    func gameEnd() {
        labelGameOver.text = "YOU WIN"
        labelGameOver.isHidden = false
        buttonStartNewGame.isHidden = false
        
        textGameScore.text = "Your score is: \(String(Game.shared.total()))"
        textGameScore.isHidden = false
        
        // Показываем вопрос и кнопки ответа
        textQuestion.isHidden = true
        buttonFirstAnswer.isHidden = true
        buttonSecondAnswer.isHidden = true
        buttonThirdAnswer.isHidden = true
        buttonFourthAnswer.isHidden = true
    }
    
    func getCorrectAnswer() {
       if let question = Game.shared.question() {
            // Заполняем контроллы вопросом
            loadQuestion(question: question)
        } else {
            // По-идее до этого не должно дойти
            self.gameEnd()
        }
    }
}
