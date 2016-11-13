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
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    public override func didSetCurrentUser() {
        super.didSetCurrentUser()
        
        Defaults[.loggedUser] = self.currentUser
        Defaults[.loggedIn] = true
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides keyboard when Tapped Arround
        super.hideKeyboardWhenTappedAround()
        Defaults.removeAll()
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
        
        UserService().loginUser("qweqweqw", password: "qweqweqe") { user in
            
            super.stopLoading()
            if let usertest = Defaults[.loggedUser]! as? User{
                super.showAlert(title: "Loggin in as", text: "\(usertest.fullName)")
            } else {


            if user != nil {
                print(user?.weightGoal)
                
                self.currentUser = user
                super.showAlert(title: "Loggin success", text: "success")
            }
            super.showAlert(title: "Error", text: "Error")
            }
        }
        
//        let authenticatedAPI = AuthenticatedDairyAPI()
        
//        authenticatedAPI.loginUser("qweq", password: "qweqweqw") { user in
//            if user != nil {
//                super.showAlert(title: "done", text: "fck yeah")
//            }
//            super.showAlert(title: "done", text: "shit")
//        }
        
//        AccountManager.defaultAccountManager.login(email: "qwerqwerqwe", password: "qwerqwerq") { success in
//            
//            if success {
//                super.stopLoading()
//                super.showAlert(title: "Successful", text: "Logged in")
//            }
//            
//            super.stopLoading()
//            super.showAlert(title: "noo", text: "noo")
//        }
        
        //perform(#selector(stopLoading),
        //    with: nil,
        //    afterDelay: 2.5)
        
        
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
