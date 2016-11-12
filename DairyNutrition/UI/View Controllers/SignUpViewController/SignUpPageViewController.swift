//
//  SignUpPageViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class SignUpPageViewController : UIPageViewController {
    
    // MARK: Properties
    weak var signUpDelegate : SignUpPageViewControllerDelegate?
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [self.newSubViewController("First"),
            self.newSubViewController("Second"),
            self.newSubViewController("Third"),
            self.newSubViewController("Fourth"),
            self.newSubViewController("Fifth"),
            self.newSubViewController("Sixth"),
            self.newSubViewController("Seventh")]
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        
        signUpDelegate?.signUpPageViewController(self, didUpdatePageCount: orderedViewControllers.count)
    }
    
    // MARK: Utilities
    
    func getViewController(index: Int) -> UIViewController {
        return orderedViewControllers[index]
    }
    
    
    // Scrolls to the next view controller
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }
    
   // Scrolls to the previous view controller
    func scrollToBeforeViewController() {
        if let visibleViewController = viewControllers?.first,
            let beforeViewController = pageViewController(self, viewControllerBefore: visibleViewController) {
            scrollToViewController(beforeViewController, direction: .reverse)
        }
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
    
    fileprivate func newSubViewController(_ number: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "SignUp\(number)ViewController")
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    fileprivate func scrollToViewController(_ viewController: UIViewController, direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }
    
    
    // Notifies '_tutorialDelegate' that the current page index was updated.
    fileprivate func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
        let index = orderedViewControllers.index(of: firstViewController) {
            signUpDelegate?.signUpPageViewController(self, didUpdatePageIndex: index)
        }
    }
    
//    func showAlertText() {
//        if let firstViewController = viewControllers?.first as? SignUpFirstViewController {
//            
//            // create the alert
//            let alert = UIAlertController(title: "My DEmo", message: firstViewController.getTextFieldValue(), preferredStyle: UIAlertControllerStyle.alert)
//            
//            // add an action (button)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
}


// MARK: UIPageViewControllerDataSource

extension SignUpPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

// MARK: UIPageViewControllerDelegate

extension SignUpPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
}

// MARK: Protocol

protocol SignUpPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func signUpPageViewController(_ signUpPageViewController: SignUpPageViewController, didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func signUpPageViewController(_ signUpPageViewController: SignUpPageViewController, didUpdatePageIndex index: Int)
}
