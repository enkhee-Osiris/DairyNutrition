//
//  LoginViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-10-27.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import PasswordTextField

class LoginViewController : MainViewController {
    
    @IBOutlet var signInButton: DesignableButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Hides keyboard when Tapped Arround
        super.hideKeyboardWhenTappedAround()
        
        // Setup back button
        // backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions
    
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        dismissVC(completion: nil)
    }
    
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {

        
        // Loading Test
        //showLoading()
        
        //perform(#selector(stopLoading),
        //    with: nil,
        //    afterDelay: 2.5)
        
        
        // Alert Test
        //let contButton = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil)
        //let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        //let buttons = [contButton, cancelButton]
        
        //showAlert(title: "Алдаа", text: "Lorem ipsum Dolar", buttons: buttons as NSArray?)
        showAlert(title: "Анхаар", text: "Sign In дарсан")
    }
    
    @IBAction func LoginWithFacebookButtonTapped(_ sender: UIButton) {
        showAlert(title: "Анхаар", text: "Login with Facebook дарсан")
    }
    @IBAction func LoginWithGoogleButtonTapped(_ sender: UIButton) {
        showAlert(title: "Анхаар", text: "Login with Google дарсан")
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
