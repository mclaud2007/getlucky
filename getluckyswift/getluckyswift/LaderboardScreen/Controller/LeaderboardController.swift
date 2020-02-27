//
//  LeaderboardController.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 20.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import UIKit

class LeaderboardController: UIViewController {
    var gameService = Game.shared
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension LeaderboardController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension LeaderboardController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameService.sessions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath) as? LeaderBoardCell else {
            preconditionFailure("Error")
        }
        
        if let sessions = gameService.sessions,
            sessions.indices.contains(indexPath.row)
        {
            cell.configure(for: sessions[indexPath.row])
        }
        
        return cell
    }
    
    
}
