//
//  AddQuestionScreen.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 26.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import UIKit

class AddQuestionScreen: UIViewController {
    @IBOutlet weak var textQuestion: UITextField!
    @IBOutlet weak var textFirstAnswer: UITextField!
    @IBOutlet weak var textSecondAnswer: UITextField!
    @IBOutlet weak var textThirdAnswer: UITextField!
    @IBOutlet weak var textFourthAnswer: UITextField!
    @IBOutlet weak var segmentedCorrectAnswer: UISegmentedControl!
    @IBOutlet weak var textQuestionPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let firstAnswer = textFirstAnswer.text,
            let secondAnswer = textSecondAnswer.text,
            let thirdAnswer = textThirdAnswer.text,
            let fourthAnswer = textFourthAnswer.text,
            let question = textQuestion.text,
            let price = textQuestionPrice.text,
            !firstAnswer.isEmpty,
            !secondAnswer.isEmpty,
            !thirdAnswer.isEmpty,
            !fourthAnswer.isEmpty,
            !question.isEmpty,
            !price.isEmpty
        {
            Game.shared.userQuestions.append(UsersQuestions(text: question, answers: [firstAnswer,secondAnswer,thirdAnswer,fourthAnswer], correct: (segmentedCorrectAnswer.selectedSegmentIndex + 1), price: Int(price) ?? 0))
            
            // Обнуляем поля
            textQuestion.text = ""
            textFirstAnswer.text = ""
            textSecondAnswer.text = ""
            textThirdAnswer.text = ""
            textFourthAnswer.text = ""
            segmentedCorrectAnswer.selectedSegmentIndex = 0
            textQuestionPrice.text = ""
            
            // И покажем сообщение что все ок
            let alert = UIAlertController(title: "Вопрос добавлен", message: "Добавить еще один вопрос?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Да", style: .default, handler: nil)
            let noAction = UIAlertAction(title: "Нет", style: .cancel) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            alert.addAction(noAction)
            alert.addAction(yesAction)
            
            present(alert, animated: true)
            
        }
    }
}
