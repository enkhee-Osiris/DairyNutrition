//
//  SignUpSixthViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import DropDown

class SignUpSixthViewController: MainViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var heightUnitButton: DesignableButton!
    
    let heightUnitDropDown = DropDown()
    
    var isCm: Bool = true
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.hideKeyboardWhenTappedAround()
        
        self.setupHeightUnitDropDown()
        
        heightTextField.addTarget(self, action: #selector(self.postNotification), for: UIControlEvents.editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utilities
    
    func setupHeightUnitDropDown() {
        self.heightUnitDropDown.anchorView = heightUnitButton
        self.heightUnitDropDown.bottomOffset = CGPoint(x: 0, y: heightUnitButton.bounds.height)
        self.heightUnitDropDown.dataSource = [
            "cm",
            "ft/in"
        ]
        
        // Appearance setup
        self.heightUnitDropDown.cellHeight = 60.0
        self.heightUnitDropDown.shadowOpacity = 0
        self.heightUnitDropDown.textFont = UIFont.systemFont(ofSize: 22)
        self.heightUnitDropDown.animationduration = 0.25
        
        // set kg selected
        self.heightUnitDropDown.selectRow(at: 0)
        
        // Action triggered on selection
        self.heightUnitDropDown.selectionAction = { [unowned self] (index, item) in
            self.heightUnitButton.setTitle(item, for: .normal)
            self.isCm = index == 0 ? true : false
        }
    }
    
    func postNotification() {
        if (self.heightTextField.text?.isNumber())! && self.isCm{
            NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillEnable, object: nil)
        }
        // TODO: check is length when ft/in checked
        else {
            NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillDisable, object: nil)
        }
    }
    
    func userHeight() -> String {
        return self.heightTextField.text!
    }
    
    func userHeightUnit() -> UserHeightUnit {
        return self.isCm ? UserHeightUnit(rawValue: 0)! : UserHeightUnit(rawValue: 1)!
    }
    
    //MARK: IBActions
    
    @IBAction func heightUnitButtonTapped(_ sender: UIButton) {
        self.heightUnitDropDown.show()
    }
    
}
