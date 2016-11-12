//
//  SignUpViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class SignUpViewController : MainViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var textsOfLabel = [
        "Таны зорилго юу вэ?",
        "How much weight would you like to gain?",
        "What is your gender?",
        "What is your activity level?",
        "What is your current weight?",
        "What is your height?",
        "What is your date of birth?"
    ]
    
    var signUpPageViewController: SignUpPageViewController? {
        didSet {
            signUpPageViewController?.signUpDelegate = self
        }
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.addNotificationObserver(Notification.Name.signInNextButtonWillEnable.rawValue, selector: #selector(self.enableNextButton))
        super.addNotificationObserver(Notification.Name.signInNextButtonWillDisable.rawValue, selector: #selector(self.disableNextButton))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let signUpPageViewController = segue.destination as? SignUpPageViewController {
            self.signUpPageViewController = signUpPageViewController
        }
    }
    
    // MARK: Utilities
    
    public func setupTextOfLabel() {
        self.questionLabel.text = textsOfLabel[pageControl.currentPage]
    }
    
    // Will enable nextButton
    func enableNextButton() {
        self.nextButton.isEnabled = true
    }
    
    // Will disable nextButton
    func disableNextButton() {
        self.nextButton.isEnabled = false
    }

    
    // MARK: IBActions
    
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        signUpPageViewController?.scrollToNextViewController()
        nextButton.isEnabled = false
        if let lastVC = signUpPageViewController?.getViewController(index: pageControl.currentPage) as? SignUpSeventhViewController {
            
            super.presentVC((UIStoryboard.mainStoryboard?.instantiateVC(SignUpWithUserInfoViewController.self))!)
            
            let dateformatter = DateFormatter()

            dateformatter.dateFormat = "MM/dd/yy"

            let now = dateformatter.string(from: lastVC.dateOfBirth!)
//
//            super.showAlert(title: "Date", text: now)
        }
    }
    
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        if (signUpPageViewController?.getViewController(index: pageControl.currentPage) as? SignUpFirstViewController) != nil{
            super.dismissVC(completion: nil)
        } else {
            signUpPageViewController?.scrollToBeforeViewController()
            self.nextButton.isEnabled = true
        }
    }
}

// MARK: Extensions
extension SignUpViewController: SignUpPageViewControllerDelegate {
    
    func signUpPageViewController(_ signUpPageViewController: SignUpPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func signUpPageViewController(_ signUpPageViewController: SignUpPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        self.setupTextOfLabel()
    }
}
