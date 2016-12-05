//
//  SignUpFifthViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import DropDown

class SignUpFifthViewController: MainViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var weightUnitButton: DesignableButton!
    
    let weightUnitDropDown = DropDown()
    
    var isKg: Bool = true
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.hideKeyboardWhenTappedAround()
        
        self.setupWeightUnitDropDown()
        
        weightTextField.addTarget(self, action: #selector(self.postNotification), for: UIControlEvents.editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utilities
    
    func setupWeightUnitDropDown() {
        self.weightUnitDropDown.anchorView = weightUnitButton
        self.weightUnitDropDown.bottomOffset = CGPoint(x: 0, y: weightUnitButton.bounds.height)
        self.weightUnitDropDown.dataSource = [
            "kg",
            "lb"
        ]
        
        // Appearance setup
        self.weightUnitDropDown.cellHeight = 60.0
        self.weightUnitDropDown.shadowOpacity = 0
        self.weightUnitDropDown.textFont = UIFont.systemFont(ofSize: 22)
        self.weightUnitDropDown.animationduration = 0.25
        
        // set kg selected
        self.weightUnitDropDown.selectRow(at: 0)
        
        // Action triggered on selection
        self.weightUnitDropDown.selectionAction = { [unowned self] (index, item) in
            self.weightUnitButton.setTitle(item, for: .normal)
            self.isKg = index == 0 ? true : false
        }
    }
    
    func postNotification() {
        if (self.weightTextField.text?.isNumber())!{
            NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillEnable, object: nil)
        } else {
            NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillDisable, object: nil)
        }
    }
    
    func userWeight() -> Double {
        return Double(self.weightTextField.text!)!
    }
    
    func userWeightUnit() -> UserWeightUnit {
        return self.isKg ? UserWeightUnit(rawValue: 0)! : UserWeightUnit(rawValue: 1)!
    }
    
    //MARK: IBActions
    
    @IBAction func weightUnitButtonTapped(_ sender: UIButton) {
        self.weightUnitDropDown.show()
    }
}
