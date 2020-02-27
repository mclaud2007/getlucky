//
//  RandomStrategy.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 27.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import Foundation

class RandomStrategy: ShowQuestionStrategy {
    func shuffle(_ questions: [Question]) -> [Question] {
        return questions.shuffled()
    }
}
