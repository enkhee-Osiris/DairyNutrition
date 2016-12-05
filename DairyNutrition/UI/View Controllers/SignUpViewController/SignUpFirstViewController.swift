//
//  SignUpFirstViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class SignUpFirstViewController: MainViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var weightGainRadioButton: RadioButton!
    @IBOutlet weak var maintainWeightRadioButton: RadioButton!
    @IBOutlet weak var loseWeightRadioButton: RadioButton!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting radio buttons as alternate
        self.weightGainRadioButton?.alternateButton = [maintainWeightRadioButton, loseWeightRadioButton]
        self.maintainWeightRadioButton?.alternateButton = [weightGainRadioButton, loseWeightRadioButton]
        self.loseWeightRadioButton?.alternateButton = [weightGainRadioButton, maintainWeightRadioButton]
        
        // super.hideKeyboardWhenTappedAround()
        
        for button in [self.weightGainRadioButton, self.maintainWeightRadioButton, self.loseWeightRadioButton]{
            button?.addTarget(self, action: #selector(self.postNotification), for: .touchUpInside)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utilites
    
    func postNotification() {
        NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillEnable, object: nil)
    }
    
    func userWeightGoalType() -> UserWeightGoal {
        if self.weightGainRadioButton.isSelected {
            return UserWeightGoal(rawValue: 0)!
        } else if self.maintainWeightRadioButton.isSelected {
            return UserWeightGoal(rawValue: 1)!
        } else {
            return UserWeightGoal(rawValue: 2)!
        }
    }
}
