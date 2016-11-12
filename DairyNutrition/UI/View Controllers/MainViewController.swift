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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Utilites
    
    func showLoading(text: String? = "Loading...") {
        
        //size of loading
        let size = CGSize(width: 30, height: 30)
        
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
    
    func getValue() {
        
    }
}
