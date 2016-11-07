//
//  SignUpViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class SignUpViewController : MainViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var textsOfLabel = [
        "What is your goal",
        "How much weight would you like to gain?",
        "What is your gender?",
        "What is your activity level?",
        "What is your current weight?",
        "What is your height?",
        "What is your date of birth?"]
    
    var signUpPageViewController: SignUpPageViewController? {
        didSet {
            signUpPageViewController?.signUpDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(SignUpViewController.didChangePageControlValue), for: .valueChanged)
        
        super.addNotificationObserver(Notification.Name.signInNextButtonWillEnable.rawValue, selector: #selector(self.enableNextButton))
        
        self.setupTextOfLabel()
        
        // Setup back button
        // backButton.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let signUpPageViewController = segue.destination as? SignUpPageViewController {
            self.signUpPageViewController = signUpPageViewController
        }
    }
    
    func setupTextOfLabel() {
        if pageControl.numberOfPages == 7 {
            questionLabel.text = textsOfLabel[pageControl.currentPage]
        }
        else {
            textsOfLabel.remove(at: 1)
            questionLabel.text = textsOfLabel[pageControl.currentPage]
        }
    }
    
    /**
     Will enable nextButton
    */
    func enableNextButton() {
        nextButton.isEnabled = true
    //    if let currentViewController = signUpPageViewController?.getViewController(index: pageControl.currentPage) as? SignUpFirstViewController{
    //        // create the alert
    //        let alert = UIAlertController(title: "My Demo", message: currentViewController.getTextFieldValue(), preferredStyle: UIAlertControllerStyle.alert)
    //        
    //        // add an action (button)
    //        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    //        
    //        // show the alert
    //        self.present(alert, animated: true, completion: nil)
    //    }
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        signUpPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    // MARK: IBActions
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        //signUpPageViewController?.showAlertText()
        signUpPageViewController?.scrollToNextViewController()
        nextButton.isEnabled = false
    }
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        if (signUpPageViewController?.getViewController(index: pageControl.currentPage) as? SignUpFirstViewController) != nil{
            super.dismissVC(completion: nil)
        } else {
            //signUpPageViewController?.showAlertText()
            signUpPageViewController?.scrollToBeforeViewController()
            nextButton.isEnabled = true
        }
    }
    
}

extension SignUpViewController: SignUpPageViewControllerDelegate {
    
    func signUpPageViewController(_ signUpPageViewController: SignUpPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func signUpPageViewController(_ signUpPageViewController: SignUpPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}

extension Notification.Name {
    static let signInNextButtonWillEnable = Notification.Name("signInNextButtonWillEnable")
}
