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
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func setupCalendar() {
        self.calendar.scope = .week
        self.calendar.firstWeekday = 2
        self.calendar.appearance.selectionColor = pinkColor
        self.calendar.select(Date())
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        print("Selected date \(self.formatter.string(from: date))")
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
    
    // MARK: ContainerViewControllerProtocol
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let containerViewViewController = segue.destination as! DashboardTableViewController
        
        containerViewViewController.delegate = self
    }
    
    // MARK: - IBActions
    
    func menuButtonTapped(_ sender: UIBarButtonItem) {
        self.openMenu()
    }
    

}
