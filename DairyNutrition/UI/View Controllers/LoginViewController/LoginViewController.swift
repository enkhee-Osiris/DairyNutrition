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
    
    @IBOutlet var keyboardLayoutConstraint: NSLayoutConstraint!
    @IBOutlet var iconTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet var signInTopLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Hides keyboard when Tapped Arround
        super.hideKeyboardWhenTappedAround()
        
        //keyboard Animation
//        NotificationCenter.default.addObserver(self, selector: #selector(self.animateWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        super.addNotificationObserver(NSNotification.Name.UIKeyboardWillChangeFrame.rawValue, selector: #selector(self.animateWithKeyboard(notification:)))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }

    func animateWithKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardLayoutConstraint?.constant = 127.0
                self.iconTopLayoutConstraint?.constant = 56.0
                self.signInTopLayoutConstraint?.constant = 59.0
            } else {
                self.keyboardLayoutConstraint?.constant = endFrame?.size.height ??  127.0
                
                self.iconTopLayoutConstraint?.constant = 26.0
                self.signInTopLayoutConstraint?.constant = 39.0
            }
           UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @IBAction func SignInButtonTapped(_ sender: UIButton) {

        
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
