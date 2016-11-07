//
//  SignUpSecondViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import DropDown

class SignUpSecondViewController: MainViewController {
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var weightUnitButton: DesignableButton!
    
    //MARK: - DropDown
    let weightUnitDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.hideKeyboardWhenTappedAround()
    
        self.setupWeightUnitDropDown()
        weightTextField.addTarget(self, action: #selector(self.postNotification), for: UIControlEvents.editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - DropDown Setup
    func setupWeightUnitDropDown() {
        weightUnitDropDown.anchorView = weightUnitButton
        
        weightUnitDropDown.bottomOffset = CGPoint(x: 0, y: weightUnitButton.bounds.height)
        
        weightUnitDropDown.dataSource = [
            "kg",
            "lb"
        ]
        
        // Appearance setup
        weightUnitDropDown.cellHeight = 60.0
        weightUnitDropDown.shadowOpacity = 0
        weightUnitDropDown.textFont = UIFont.systemFont(ofSize: 22)
        weightUnitDropDown.animationduration = 0.25
        
        weightUnitDropDown.selectRow(at: 0)
        
        // Action triggered on selection
        weightUnitDropDown.selectionAction = { [unowned self] (index, item) in
            self.weightUnitButton.setTitle(item, for: .normal)
        }
    }

    // Will post signInNextButtonWillEnable notification
    func postNotification() {
        //TODO: Check textfield value is available
        NotificationCenter.default.post(name: Notification.Name.signInNextButtonWillEnable, object: nil)
    }
    
    //MARK: IBActions
    @IBAction func weightUnitButtonTapped(_ sender: UIButton) {
        weightUnitDropDown.show()
    }
    
}
