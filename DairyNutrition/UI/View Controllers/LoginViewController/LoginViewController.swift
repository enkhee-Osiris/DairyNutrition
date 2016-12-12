//
//  LoginViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-10-27.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import PasswordTextField
import SwiftyUserDefaults

class LoginViewController : MainViewController {
    
    // MARK: Properties
    
    @IBOutlet var signInButton: DesignableButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    func didSetCurrentUser() {
        
        Defaults[.loggedUser] = Shared.shared.currentUser
        Defaults[.loggedIn] = true
        
        if Defaults[.loggedIn]! {
            super.presentVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "BaseViewController"))!)
        }
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides keyboard when Tapped Arround
        super.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions
    
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        super.dismissVC(completion: nil)
    }
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        // Loading Test
        super.showLoading()
        
        if !(emailTextField.text?.isEmail)! {
            super.stopLoading()
            super.showAlert(title: "Warning", text: "Email is not available")
        } else {
            UserService().loginUser(emailTextField.text!, password: passwordTextField.text!) { user in
                
                super.stopLoading()
                
                if user != nil {
                    Shared.shared.currentUser = user
                    self.didSetCurrentUser()

                } else {
                    super.showAlert(title: "Error", text: "There is some error")
                }
            }
        }
        
        // Alert Test
        //let contButton = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil)
        //let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        //let buttons = [contButton, cancelButton]
        
        //showAlert(title: "Алдаа", text: "Lorem ipsum Dolar", buttons: buttons as NSArray?)
        //super.showAlert(title: "Анхаар", text: "Sign In дарсан")
    }
    
    @IBAction func LoginWithFacebookButtonTapped(_ sender: UIButton) {
        super.showAlert(title: "Анхаар", text: "Login with Facebook дарсан")
    }
    
    @IBAction func LoginWithGoogleButtonTapped(_ sender: UIButton) {
        super.showAlert(title: "Анхаар", text: "Login with Google дарсан")
    }
    
    @IBAction func ForgotPasswordButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Forgot Password", message: "Enter your email address", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Email address"
        }
        
        // OK Button
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = alert.textFields![0] // Force unwrapping because we know it exists.
            print("Email field: \(textField.text)")
        }))
        
        // Cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
