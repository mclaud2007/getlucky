//
//  Question.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 19.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import Foundation

class Question {
    var text: String
    var answers: [String]
    var correct: Int
    var price: Int
    
    init (text: String, answers: [String], correct number: Int, price: Int) {
        self.text = text
        self.answers = answers
        self.correct = number
        self.price = price
    }
}
