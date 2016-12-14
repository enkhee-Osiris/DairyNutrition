//
//  MainViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-10-27.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class MainViewController : UIViewController, NVActivityIndicatorViewable {
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.addNotificationObserver(Notification.Name.noNetworkConnection.rawValue, selector: #selector(self.showNetworkAlert))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utilites
    
    func showLoading(text: String? = "") {
        
        //size of loading
        let size = CGSize(width: 50, height: 50)
        
        self.startAnimating(size, message: text, type: NVActivityIndicatorType.ballGridPulse)
    }
    
    func stopLoading() {
        stopAnimating()
    }

    func showAlert(title: String, text: String, buttons: NSArray? = nil) {
        
        // Example of element in buttons
        // UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
        // (UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // create the alert
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.alert)
        
        if buttons == nil {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        } else {
        
            // Adding the button actions
            for button in buttons! {
                alert.addAction(button as! UIAlertAction)
            }
        }
        
        // Shows the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNetworkAlert() {
        showAlert(title: "Network Error", text: "Check your internet connection")
    }
    
    func setupNavigationBar() {
        //self.navigationController?.navigationBar.barStyle = UIBarStyle.
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = pinkColor
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,
                                                                        NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)]
        
        
        let backImage = UIImage(named: "back-inverted-icon")
        self.navigationController?.navigationBar.backIndicatorImage = backImage?.resizeWithHeight(26.0)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage?.resizeWithHeight(26.0)
    }
}
