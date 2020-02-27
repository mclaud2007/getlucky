//
//  NormalStrategy.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 27.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import Foundation

// В нормальной стратегии ничего не делаем с вопросами
class NormalStrategy: ShowQuestionStrategy {
    func shuffle(_ question: [Question]) -> [Question] {
        question
    }
}
