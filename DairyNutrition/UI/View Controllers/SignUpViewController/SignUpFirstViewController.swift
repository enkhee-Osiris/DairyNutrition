//
//  SignUpFirstViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class SignUpFirstViewController: MainViewController {
    
    @IBOutlet weak var weightGainRadioButton: RadioButton!
    @IBOutlet weak var maintainWeightRadioButton: RadioButton!
    @IBOutlet weak var loseWeightRadioButton: RadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setting radia buttons as alternate
        weightGainRadioButton?.alternateButton = [maintainWeightRadioButton, maintainWeightRadioButton]
        maintainWeightRadioButton?.alternateButton = [weightGainRadioButton, loseWeightRadioButton]
        loseWeightRadioButton?.alternateButton = [weightGainRadioButton, maintainWeightRadioButton]
        
//        super.hideKeyboardWhenTappedAround()
        
        for button in [weightGainRadioButton, maintainWeightRadioButton, loseWeightRadioButton]{
            button?.addTarget(self, action: #selector(self.postNotification), for: .touchUpInside)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillEnable, object: nil)
    }
    
//    func textFieldDidChange() {
//        NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillEnable, object: nil)
//    }
//    
//    func getTextFieldValue() -> String {
//        if let text = textField.text {
//            return text
//        }
//        return "Hooson"
//    }
    
}
