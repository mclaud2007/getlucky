//  ViewController.swift
//  getluckyswift
//
//  Created by Григорий Мартюшин on 26.02.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

import UIKit

class SettingsScreen: UIViewController {
    @IBOutlet weak var questionTypeSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch Game.shared.questionShowType {
        case .random:
            questionTypeSelector.selectedSegmentIndex = 1
        default:
            questionTypeSelector.selectedSegmentIndex = 0
        }
        
    }
    
    @IBAction func questionTypeSegmentChanged(_ sender: Any) {
        switch questionTypeSelector.selectedSegmentIndex {
        case 1:
            Game.shared.questionShowType = .random
        default:
            Game.shared.questionShowType = .normal
        }
        
    }
}
