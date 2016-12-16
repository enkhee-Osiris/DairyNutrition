//
//  AddFoodViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-12.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import CoreData
import AlecrimCoreData


class AddFoodViewController: MainViewController, FoodsTableProtocol, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var crabsLabel: UILabel!
    
    @IBOutlet weak var protLabel: UILabel!
    
    @IBOutlet weak var rdiLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var foodsTableView: UITableView!
    
    @IBOutlet weak var foodsTableHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var caloriesRemainingLabel: UILabel!
    
    @IBOutlet weak var caloriesConsumedLabel: UILabel!
    
    
    fileprivate private(set) lazy var fetchRequestController: FetchRequestController<CoreFood> = {
        let query = persistentContainer.viewContext.foods.filter{ $0.date == Shared.shared.selectedDate }.orderBy{ $0.name }
        
        print("\(persistentContainer.viewContext.foods.orderBy{ $0.date }.map{ $0.date })")
        
        return query.toFetchRequestController()
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add Food"

        //self.fetchRequestController.bind(to: self.tableView)
        
        self.fetchRequestController.bind(to: self.foodsTableView)
        
        self.setupFoodsTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rowHeight = CGFloat(44)
        let headerHeight = foodsTableView.sectionHeaderHeight
        let count = self.fetchRequestController.numberOfObjects(inSection: 0) == 0 ? 1 : self.fetchRequestController.numberOfObjects(inSection: 0)
        
        let height = (CGFloat(count) * rowHeight) + headerHeight
        self.foodsTableHeightContraint.constant = height
        
        
//        print("\([1...3].reduce(0.0, combine: +))")
        
        //print(self.fetchRequestController.fetchedObjects?.map{ $0.nutrients.map{ $0.name } })
        
        self.setupNutrients()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Custom functions
    
    func setupFoodsTableView() {
        let view = (Bundle.main.loadNibNamed("FoodsTableSectionHeader", owner: self, options: nil)?[0] as? FoodsTableSectionHeader)
        
        self.foodsTableView.tableHeaderView = view
        view?.delegate = self
    }
    
    func pushFoodSearchViewController() {
        super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "FoodSearchViewController"))!)
    }
    
    func setupNutrients(){
        
        if((self.fetchRequestController.fetchedObjects?.count)! > 0) {
            
            let quantity = self.fetchRequestController.fetchedObjects?.flatMap{ $0.quantity }
            
            let calories = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Energy" }.flatMap{ $0.value }}
            let caloriesUnit = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Energy" }}[0].unit
            caloriesLabel.text = "\(Int(sumArray(array: calories!, quantity: quantity!))) \(caloriesUnit!)"
            
            let fat = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Total lipid (fat)" }.flatMap{ $0.value }}
            let fatUnit = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Total lipid (fat)" }}[0].unit
            fatLabel.text = "\(sumArray(array: fat!, quantity: quantity!))\(fatUnit!)"
            
            let protein = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Protein" }.flatMap{ $0.value }}
            let proteinUnit = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Protein" }}[0].unit
            protLabel.text = "\(sumArray(array: protein!, quantity: quantity!))\(proteinUnit!)"
            
            let carb = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Carbohydrate, by difference" }.flatMap{ $0.value }}
            let carbUnit = self.fetchRequestController.fetchedObjects?.flatMap{ $0.nutrients.filter{ $0.name == "Carbohydrate, by difference" }}[0].unit
            crabsLabel.text = "\(sumArray(array: carb!, quantity: quantity!))\(carbUnit!)"
            
            let neededCalories = Shared.shared.currentUser.calculateCalories()
            caloriesRemainingLabel.text = "\(neededCalories - Int(sumArray(array: calories!, quantity: quantity!)))\(caloriesUnit!)"
            
            caloriesConsumedLabel.text = "\(Int(sumArray(array: calories!, quantity: quantity!)))\(caloriesUnit!)"
            
            let a = sumArray(array: calories!, quantity: quantity!)
            
            print(a)
            
            print(Int(a / Double(neededCalories) * 100.0))
            
            rdiLabel.text = "\(Int(sumArray(array: calories!, quantity: quantity!) / Double(neededCalories) * 100.0))%"
        }
    
    }
}
    // MARK: - UITableViewDelegate

extension AddFoodViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchRequestController.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchRequestController.numberOfObjects(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodsTableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        
        let food = self.fetchRequestController.object(at: indexPath)
        
        cell.textLabel!.text = food.name
        let calories = Int(food.nutrients.filter{ $0.name == "Energy" }[0].value)
        let quantity = Int(food.quantity)
        cell.detailTextLabel!.text = "\(calories * quantity)"
        
        return cell
    }
}
