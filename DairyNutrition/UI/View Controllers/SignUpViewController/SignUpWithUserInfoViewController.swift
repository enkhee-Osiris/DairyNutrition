//
//  SignUpWithUserInfoViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-09.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import UIKit
import PasswordTextField

class SignUpWithUserInfoViewController: MainViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides keyboard when tapped around
        super.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBActions
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        if (firstNameTextField.text != "") || (lastNameTextField.text != "") || (emailTextField.text != "") {
            
            if !(emailTextField.text?.isEmail)! {
                super.showAlert(title: "Warning", text: "Email is not available")
            }
            if passwordTextField.isInvalid() {
                super.showAlert(title: "Error", text: passwordTextField.errorMessage())
            }
            
        } else {
            super.showAlert(title: "Error", text: "You must fill all fields")
        }
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func googlePlusButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        super.dismissVC(completion: nil)
    }
    
    
    
}
