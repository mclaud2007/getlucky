//
//  TableViewCell.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 20.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import UIKit

class LeaderBoardCell: UITableViewCell {

    @IBOutlet weak var lblAnswers: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblSessionNumber: UILabel!
    
    override func prepareForReuse() {
        lblAnswers.text = "0"
        lblScore.text = "0"
        lblSessionNumber.text = "0"
    }
    
    public func configure(for session: GameSession){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        
        lblAnswers.text = String(session.answerQuestions)
        lblScore.text = String(session.totalScore)
        lblSessionNumber.text = dateFormatter.string(from: session.date)
    }
}
