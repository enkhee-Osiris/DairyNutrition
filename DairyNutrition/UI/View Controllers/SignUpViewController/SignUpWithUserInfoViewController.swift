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
    
    // User Properties
    
    var weightGoalType: UserWeightGoal?
    var weightGoal: Double?
    var weightGoalUnit: UserWeightUnit?
    
    var gender: UserGender?
    var activityLevel: UserActivityLevel?
    
    var weight: Double?
    var weightUnit: UserWeightUnit?
    
    var height: String?
    var heightUnit: UserHeightUnit?

    var dateOfBirth: String?
    
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
//        super.showAlert(title: "Test", text: "\(self.height)")
        if (firstNameTextField.text != "") || (lastNameTextField.text != "") || (emailTextField.text != "") {
            
            if !(emailTextField.text?.isEmail)! {
                super.showAlert(title: "Warning", text: "Email is not available")
            }
            if passwordTextField.isInvalid() {
                super.showAlert(title: "Error", text: passwordTextField.errorMessage())
            }
            if (emailTextField.text?.isEmail)! && passwordTextField.isValid() {
                print("fine")
                let regUser = User(fullName: firstNameTextField.text! + " " + lastNameTextField.text!,
                                   email: emailTextField.text!,
                                   weightGoalType: weightGoalType!,
                                   weightGoal: weightGoal!,
                                   weightGoalUnit: weightGoalUnit!,
                                   gender: gender!,
                                   activityLevel: activityLevel!,
                                   weight: weight!,
                                   weightUnit: weightUnit!,
                                   height: height!,
                                   heightUnit: heightUnit!,
                                   dateOfBirth: dateOfBirth!)
                
                UserService().registerUser(user: regUser, password: passwordTextField.text!) { success, msg in
                    if success {
                        super.showAlert(title: "Successful", text: msg)
                    } else {
                        super.showAlert(title: "Error", text: msg)
                    }
                }
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
