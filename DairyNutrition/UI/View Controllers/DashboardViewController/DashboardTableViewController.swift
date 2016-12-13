//
//  DashboardViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-06.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class DashboardTableViewController: UITableViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var caloriesNeedLabel: UILabel!
    
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    
    @IBOutlet weak var currentWeightLabel: UILabel!
    
    var delegate: ContainerViewControllerProtocol?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides keyboard when Tapped Arround
        self.caloriesNeedLabel.text = Shared.shared.currentUser?.calculateCalories().description
        self.caloriesNeedLabel.sizeToFit()
        //self.caloriesNeededLabel.text = "SUKA"
        
        self.tableView.tableFooterView = UIView()        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - IBActions
    
    @IBAction func addFoodButtonTapped(_ sender: Any) {
        self.delegate?.pushAddFoodViewController()
    }
    @IBAction func addExerciseButtonTapped(_ sender: Any) {
        self.delegate?.pushAddExerciseViewController()
    }
}

protocol ContainerViewControllerProtocol {
    func pushAddFoodViewController()
    func pushAddExerciseViewController()
}
