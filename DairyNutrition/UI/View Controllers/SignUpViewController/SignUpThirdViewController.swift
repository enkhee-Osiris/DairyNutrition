//
//  SignUpThirdViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class SignUpThirdViewController: MainViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var maleRadioButton: RadioButton!
    
    @IBOutlet weak var femaleRadioButton: RadioButton!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.maleRadioButton?.alternateButton = [self.femaleRadioButton!]
        self.femaleRadioButton?.alternateButton = [self.maleRadioButton!]
        
        self.maleRadioButton?.setImage(UIImage.init(named: "male-icon.png"), for: .selected)
        self.femaleRadioButton?.setImage(UIImage.init(named: "female-icon.png"), for: .selected)
        
        for button in [self.maleRadioButton, self.femaleRadioButton]{
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
    
    func userGender() -> UserGender {
        if self.maleRadioButton.isSelected {
            return UserGender(rawValue: 0)!
        } else {
            return UserGender(rawValue: 1)!
        }
    }
}
