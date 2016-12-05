//
//  SignUpFourthViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class SignUpFourthViewController: MainViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var sedentaryRadioButton: RadioButtonWithSubtext!
    
    @IBOutlet weak var lowActiveRadioButton: RadioButtonWithSubtext!
    
    @IBOutlet weak var activeRadioButton: RadioButtonWithSubtext!
    
    @IBOutlet weak var veryActiveRadioButton: RadioButtonWithSubtext!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sedentaryRadioButton?.alternateButton = [lowActiveRadioButton, activeRadioButton, veryActiveRadioButton]
        self.lowActiveRadioButton?.alternateButton = [sedentaryRadioButton, activeRadioButton, veryActiveRadioButton]
        self.activeRadioButton?.alternateButton = [sedentaryRadioButton, lowActiveRadioButton, veryActiveRadioButton]
        self.veryActiveRadioButton?.alternateButton = [sedentaryRadioButton, lowActiveRadioButton, activeRadioButton]
        
        // Posts notification when buttons are tapped
        for button in [self.sedentaryRadioButton, self.lowActiveRadioButton, self.activeRadioButton, self.veryActiveRadioButton]{
            button?.addTarget(self, action: #selector(self.postNotification), for: .touchUpInside)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utilities
    
    func postNotification() {
        NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillEnable, object: nil)
    }
    
    func userActivityLevel() -> UserActivityLevel {
        if self.sedentaryRadioButton.isSelected {
            return UserActivityLevel(rawValue: 0)!
        } else if self.lowActiveRadioButton.isSelected {
            return UserActivityLevel(rawValue: 1)!
        } else if self.activeRadioButton.isSelected {
            return UserActivityLevel(rawValue: 2)!
        } else {
            return UserActivityLevel(rawValue: 3)!
        }
    }
}
