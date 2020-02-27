//
//  UsersQuestionsCaretaker.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 27.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import Foundation

class UsersQuestionsCaretaker {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let key = "usersQuestions"
    
    func save(_ questions: [UsersQuestions]) throws {
        let data: Data = try encoder.encode(questions)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func load() throws -> [UsersQuestions] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data,
            let questions = try? decoder.decode([UsersQuestions].self, from: data) else {
                throw GameError.usersQuestionsNotFound
        }
        
        return questions
    }
}
