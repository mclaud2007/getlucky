//
//  GameCaretacer.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 26.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import Foundation

class GameCaretaker {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let key = "getLucky"
    
    func saveGame(_ sessions: [GameSession]) throws {
        let data: Data = try encoder.encode(sessions)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadGame() throws -> [GameSession] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data,
            let sessions = try? decoder.decode([GameSession].self, from: data) else {
                throw GameError.sessionsNotFound
        }
        
        return sessions
    }
}
