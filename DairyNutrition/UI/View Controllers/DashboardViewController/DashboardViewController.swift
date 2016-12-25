//
//  DashboardViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import FSCalendar
import KYDrawerController

class DashboardViewController: MainViewController, FSCalendarDataSource, FSCalendarDelegate, ContainerViewControllerProtocol {
    
    // MARK: Properties
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var containerViewViewController: DashboardTableViewController?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.addNotificationObserver(Notification.Name.pushFoodDairy.rawValue, selector: #selector(self.pushFoodDairy))
        super.addNotificationObserver(Notification.Name.pushExerciseDairy.rawValue, selector: #selector(self.pushExerciseDairy))
        super.addNotificationObserver(Notification.Name.pushWeightTracker.rawValue, selector: #selector(self.pushWeightTracker))
        super.addNotificationObserver(Notification.Name.pushSettings.rawValue, selector: #selector(self.pushSettings))
        
        self.setupCalendar()
        
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "menu-inverted-icon"), for: UIControlState.normal)
        menuButton.addTarget(self, action:#selector(menuButtonTapped), for: UIControlEvents.touchUpInside)
        menuButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 26)
        let barButton = UIBarButtonItem.init(customView: menuButton)
        self.navigationItem.leftBarButtonItem = barButton
        
        super.setupNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Custom Function
    
    func pushFoodDairy() {
        self.closeMenu()
        self.pushAddFoodViewController()
    }
    
    func pushExerciseDairy() {
        self.closeMenu()
        self.pushAddExerciseViewController()
    }

    func pushWeightTracker() {
        self.closeMenu()
        //super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "AddExerciseViewController"))!)
    }
    
    func pushSettings() {
        self.closeMenu()
        //super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "AddExerciseViewController"))!)
    }
    
    func setupCalendar() {
        self.calendar.scope = .week
        self.calendar.firstWeekday = 2
        self.calendar.appearance.selectionColor = pinkColor
        self.calendar.select(Date())
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        Shared.shared.selectedDate = formatter.string(from: date)
        
        containerViewViewController?.setupCalories()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date) -> Bool {
        if date.compare(Date()) == ComparisonResult.orderedDescending {
            return false
        }
        return true
    }
    
    func pushAddFoodViewController() {
        super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "AddFoodViewController"))!)
    }
    func pushAddExerciseViewController() {
        super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "AddExerciseViewController"))!)
    }
    
    func closeMenu() {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
        }
    }
    
    func openMenu() {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    func menuTableViewController(menuIndex: Int) {
        switch menuIndex {
        case 2:
            self.pushAddFoodViewController()
        case 3:
            self.pushAddExerciseViewController()
        default:
            print("Menu default")
        }
    }
    
    // MARK: ContainerViewControllerProtocol
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        containerViewViewController = segue.destination as? DashboardTableViewController
        
        containerViewViewController?.delegate = self
    }
    
    // MARK: - IBActions
    
    func menuButtonTapped(_ sender: UIBarButtonItem) {
        self.openMenu()
    }
}

