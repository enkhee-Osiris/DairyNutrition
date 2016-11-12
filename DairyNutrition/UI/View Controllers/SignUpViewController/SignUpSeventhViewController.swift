//
//  SignUpSeventhViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class SignUpSeventhViewController: MainViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var dateOfBirthDatePicker: UIDatePicker!
    
    var dateOfBirth: Date?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBActions
    
    @IBAction func dateOfBirthValueChanged(_ sender: Any) {
        self.dateOfBirth = dateOfBirthDatePicker.date
        NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillEnable, object: nil)
    }
}
