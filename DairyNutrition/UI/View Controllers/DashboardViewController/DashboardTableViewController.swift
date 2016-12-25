//
//  DashboardViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-06.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import AlecrimCoreData

//let context = DataContext()

class DashboardTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var caloriesNeedLabel: UILabel!
    
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    
    @IBOutlet weak var currentWeightLabel: UILabel!
    
    @IBOutlet weak var caloriesConsumedLabel: UILabel!
    
    var delegate: ContainerViewControllerProtocol?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides keyboard when Tapped Arround
        self.caloriesNeedLabel.text = Shared.shared.currentUser?.calculateCalories().description
        self.caloriesNeedLabel.sizeToFit()
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCalories()
    }
    
    // MARK: - Custom Functions
    
    func setupCalories(){
        let foods = persistentContainer.viewContext.foods.filter{ $0.date == Shared.shared.selectedDate }
        let exercises = persistentContainer.viewContext.exercises.filter{ $0.date == Shared.shared.selectedDate }
        
        if foods.count() != 0 {
            let calories = foods.flatMap{ $0.nutrients.filter{ $0.name == "Energy" }.flatMap{ $0.value }}
            let quantity = foods.flatMap{ $0.quantity }
            let caloriesUnit = foods.flatMap{ $0.nutrients.filter{ $0.name == "Energy" }}[0].unit
            
            let caloriesConsumed = "\(Shared.shared.currentUser.calculateCalories() - Int(sumArray(array: calories, quantity: quantity))) \(caloriesUnit)"
            let caloriesNeed = "\(Int(sumArray(array: calories, quantity: quantity))) \(caloriesUnit)"
            
            self.setLabel(caloriesConsumed: caloriesConsumed, caloriesNeed: caloriesNeed)
        } else {
            self.setLabel(caloriesConsumed: "\(Shared.shared.currentUser.calculateCalories()) kcal", caloriesNeed: "0 kcal")
        }
        
        if exercises.count() != 0 {
            let calories = Int(exercises.flatMap{ $0.value }.reduce(0, +))
            self.caloriesBurnedLabel.text = "\(calories)"
        } else {
            self.caloriesBurnedLabel.text = "0"
        }
    
        self.currentWeightLabel.text = "\(Shared.shared.currentUser.weight!) kg"
    }
    
    func setLabel(caloriesConsumed: String, caloriesNeed: String){
        self.caloriesNeedLabel.text = "\(caloriesConsumed)"
        self.caloriesConsumedLabel.text = "\(caloriesNeed)"
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
